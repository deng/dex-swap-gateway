import { Hono } from 'hono';
import { cors } from 'hono/cors';

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------
export interface Env {
  OKX_API_KEY: string;
  OKX_SECRET_KEY: string;
  OKX_API_PASSPHRASE: string;
  OKX_PROJECT_ID: string;
  OKX_BASE_URL: string;
  TOKEN_CACHE_TTL: string; // seconds, e.g. "60"
}

type ChainMap = Record<string, string>;

// OKX chain ID mapping: wallet ChainType → OKX chain ID
const CHAIN_MAP: ChainMap = {
  eth: '43114',        // OKX's ID for Ethereum
  bsc: '56',
  polygon: '137',
  base: '8453',
  arbitrum: '42161',
  optimism: '10',
  sui: '501',
  ton: '607',
  trx: '195',
};

// ---------------------------------------------------------------------------
// HMAC-SHA256 signing for OKX API
// ---------------------------------------------------------------------------
async function signAsync(
  secretKey: string,
  timestamp: string,
  method: string,
  requestPath: string,
  body?: string,
): Promise<string> {
  const message = timestamp + method + requestPath + (body ?? '');
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secretKey),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign('HMAC', key, new TextEncoder().encode(message));
  return btoa(String.fromCharCode(...new Uint8Array(signature)));
}

// ---------------------------------------------------------------------------
// OKX API proxy helpers
// ---------------------------------------------------------------------------
interface OkxRequest {
  method: string;       // 'GET' | 'POST'
  path: string;         // e.g. '/api/v5/dex/aggregator/quote'
  query?: string;
  body?: string;
}

async function proxyOkx(env: Env, req: OkxRequest): Promise<Response> {
  const timestamp = new Date().toISOString();
  const requestPath = req.path + (req.query ? '?' + req.query : '');
  const signature = await signAsync(
    env.OKX_SECRET_KEY,
    timestamp,
    req.method,
    requestPath,
    req.body,
  );

  const url = `${env.OKX_BASE_URL}${requestPath}`;
  const headers: Record<string, string> = {
    'OK-ACCESS-KEY': env.OKX_API_KEY,
    'OK-ACCESS-SIGN': signature,
    'OK-ACCESS-TIMESTAMP': timestamp,
    'OK-ACCESS-PASSPHRASE': env.OKX_API_PASSPHRASE,
    'OK-ACCESS-PROJECT': env.OKX_PROJECT_ID,
    'Content-Type': 'application/json',
  };

  const fetchInit: RequestInit = {
    method: req.method,
    headers,
  };
  if (req.body) {
    fetchInit.body = req.body;
  }

  const response = await fetch(url, fetchInit);

  // Proxy response, adding client-facing cache header
  const respHeaders = new Headers(response.headers);
  // OKX responses are short-lived; add a small cache for repeat queries
  respHeaders.set('Cache-Control', 'public, max-age=2');

  return new Response(response.body, {
    status: response.status,
    headers: respHeaders,
  });
}

// ---------------------------------------------------------------------------
// Token list with per-chain cache
// ---------------------------------------------------------------------------
interface CacheEntry {
  data: any;
  expiresAt: number;
}
const tokenCache = new Map<string, CacheEntry>();

async function getTokens(env: Env, chain: string): Promise<Response> {
  const okxChain = CHAIN_MAP[chain];
  if (!okxChain) {
    return new Response(JSON.stringify({ error: `Unsupported chain: ${chain}` }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Check cache
  const cacheKey = `tokens:${chain}`;
  const cached = tokenCache.get(cacheKey);
  const ttl = parseInt(env.TOKEN_CACHE_TTL || '60', 10);
  if (cached && Date.now() < cached.expiresAt) {
    return new Response(JSON.stringify(cached.data), {
      headers: {
        'Content-Type': 'application/json',
        'X-Cache': 'HIT',
        'Cache-Control': `public, max-age=${ttl}`,
      },
    });
  }

  const response = await proxyOkx(env, {
    method: 'GET',
    path: `/api/v5/dex/aggregator/tokens`,
    query: `chainId=${okxChain}`,
  });

  if (response.ok) {
    const data = await response.json();
    tokenCache.set(cacheKey, { data, expiresAt: Date.now() + ttl * 1000 });
    return new Response(JSON.stringify(data), {
      headers: {
        'Content-Type': 'application/json',
        'X-Cache': 'MISS',
        'Cache-Control': `public, max-age=${ttl}`,
      },
    });
  }

  return response;
}

// ---------------------------------------------------------------------------
// Hono app
// ---------------------------------------------------------------------------
const app = new Hono<{ Bindings: Env }>();

// CORS for wallet app
app.use('*', cors({
  origin: '*',
  allowMethods: ['GET', 'POST', 'OPTIONS'],
  allowHeaders: ['Content-Type'],
  maxAge: 86400,
}));

// Health check
app.get('/api/v1/health', (c) => {
  return c.json({
    status: 'healthy',
    service: 'dex-swap-gateway',
    timestamp: new Date().toISOString(),
  });
});

// Get tokens for a chain
app.get('/api/v1/dex-swap/tokens', async (c) => {
  const chain = c.req.query('chain');
  if (!chain) {
    return c.json({ error: 'Missing chain parameter' }, 400);
  }
  return getTokens(c.env, chain);
});

// Get quote
app.get('/api/v1/dex-swap/quote', async (c) => {
  const chain = c.req.query('chain');
  if (!chain) return c.json({ error: 'Missing chain' }, 400);

  const okxChain = CHAIN_MAP[chain];
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const fromToken = c.req.query('fromToken');
  const toToken = c.req.query('toToken');
  const amount = c.req.query('amount');
  const slippage = c.req.query('slippage');

  if (!fromToken || !toToken || !amount) {
    return c.json({ error: 'Missing required parameters: fromToken, toToken, amount' }, 400);
  }

  const queryParams = new URLSearchParams({
    chainId: okxChain,
    fromTokenAddress: fromToken,
    toTokenAddress: toToken,
    amount,
    slippage: slippage || '50', // default 0.5%
  });

  return proxyOkx(c.env, {
    method: 'GET',
    path: '/api/v5/dex/aggregator/quote',
    query: queryParams.toString(),
  });
});

// Build swap transaction
app.post('/api/v1/dex-swap/build-tx', async (c) => {
  const body = await c.req.json();
  const chain = body.chain;
  const okxChain = CHAIN_MAP[chain];
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const okxBody = {
    chainId: okxChain,
    fromTokenAddress: body.fromToken,
    toTokenAddress: body.toToken,
    amount: body.amount,
    slippage: body.slippage || '50',
    userWalletAddress: body.fromAddress,
  };

  return proxyOkx(c.env, {
    method: 'POST',
    path: '/api/v5/dex/aggregator/swap',
    body: JSON.stringify(okxBody),
  });
});

// Build approval transaction
app.post('/api/v1/dex-swap/build-approve', async (c) => {
  const body = await c.req.json();
  const chain = body.chain;
  const okxChain = CHAIN_MAP[chain];
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const okxBody = {
    chainId: okxChain,
    tokenAddress: body.token,
    spender: body.spender,
    amount: body.amount || '115792089237316195423570985008687907853269984665640564039457584007913129639935', // MaxUint256
  };

  return proxyOkx(c.env, {
    method: 'POST',
    path: '/api/v5/dex/aggregator/approve',
    body: JSON.stringify(okxBody),
  });
});

// ---------------------------------------------------------------------------
// Export for Cloudflare Worker
// ---------------------------------------------------------------------------
export default {
  fetch: app.fetch,
};

// ---------------------------------------------------------------------------
// Re-export for testing
// ---------------------------------------------------------------------------
export { signAsync, CHAIN_MAP };
