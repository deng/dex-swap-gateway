import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { CHAIN_REGISTRY, resolveChain as resolveChainInfo } from '@zero-wallet/chain-utils';
import { keccak256 } from 'js-sha3';

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
  JUPITER_BASE_URL: string;
  JUPITER_TOKENS_BASE_URL: string;
  JUPITER_API_KEY: string;
}

// Supported chains (short names that are enabled for DEX swap)
const SUPPORTED_CHAINS = new Set(['eth', 'bsc', 'polygon', 'base', 'arbitrum', 'optimism', 'sui', 'ton', 'trx']);

// Trust Wallet blockchain directory names for logo CDN
const TW_CHAINS: Record<string, string> = {
  eth: 'ethereum',
  bsc: 'smartchain',
  polygon: 'polygon',
  base: 'base',
  arbitrum: 'arbitrum',
  optimism: 'optimism',
  trx: 'tron',
};
// sui, ton: no Trust Wallet blockchain directory — logos fall through to OKX CDN

/** Resolve a chain identifier (short name or CAIP-2) to an OKX chainIndex */
function resolveChain(chain: string): string | undefined {
  if (!chain) return undefined;
  const info = resolveChainInfo(chain);
  if (!info?.okxChainIndex || !SUPPORTED_CHAINS.has(info.shortName)) return undefined;
  return info.okxChainIndex;
}

// EIP-55 checksum address encoding (only for valid 40-char hex addresses)
function toChecksumAddress(address: string): string {
  const addr = address.toLowerCase().replace('0x', '');
  if (addr.length !== 40 || !/^[0-9a-f]{40}$/.test(addr)) return address;
  const hash = keccak256(addr);
  let checksummed = '0x';
  for (let i = 0; i < 40; i++) {
    checksummed += parseInt(hash[i], 16) >= 8 ? addr[i].toUpperCase() : addr[i];
  }
  return checksummed;
}

// Build Trust Wallet CDN logo URL for a token, or null if chain isn't supported
function logoUrl(chain: string, address: string): string | null {
  const twChain = TW_CHAINS[chain];
  if (!twChain) return null;
  const addr = address.startsWith('0x') ? toChecksumAddress(address) : address;
  return `https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/${twChain}/assets/${addr}/logo.png`;
}

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
// Proxy helpers
// ---------------------------------------------------------------------------
interface ProxyRequest {
  method: string;
  path: string;
  query?: string;
  body?: string;
  baseUrl?: string; // optional base URL override (e.g., for Jupiter tokens API)
}

async function proxyOkx(env: Env, req: ProxyRequest): Promise<Response> {
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

async function getTokens(env: Env, chain: string, host: string): Promise<Response> {
  const okxChain = resolveChain(chain);
  if (!okxChain) {
    return new Response(JSON.stringify({ error: `Unsupported chain: ${chain}` }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Get short name for logo URL construction
  const info = resolveChainInfo(chain);
  const shortName = info?.shortName || chain;

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
    path: '/api/v6/dex/aggregator/all-tokens',
    query: `chainIndex=${okxChain}`,
  });

  if (response.ok) {
    const data = await response.json() as { code?: string; msg?: string; data?: any[] };
    // Rewrite tokenLogoUrl to gateway proxy for Trust Wallet-supported chains
    const twChain = TW_CHAINS[shortName];
    const NATIVE_TOKEN_ADDRESS = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE';
    if (data.data && Array.isArray(data.data)) {
      data.data = data.data.map((token: any) => {
        const addr = token.tokenContractAddress;
        if (!twChain || addr === NATIVE_TOKEN_ADDRESS) return token;
        return {
          ...token,
          tokenLogoUrl: `${host}/api/v1/dex-swap/tokens/${shortName}/${addr}/logo`,
        };
      });
    }
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
// Jupiter API proxy helpers
// ---------------------------------------------------------------------------
async function proxyJupiter(env: Env, req: ProxyRequest): Promise<Response> {
  const base = req.baseUrl ?? env.JUPITER_BASE_URL;
  const url = `${base}${req.path}${req.query ? '?' + req.query : ''}`;
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    'x-api-key': env.JUPITER_API_KEY,
  };

  const fetchInit: RequestInit = {
    method: req.method,
    headers,
  };
  if (req.body) {
    fetchInit.body = req.body;
  }

  let response: Response;
  try {
    response = await fetch(url, fetchInit);
  } catch (err) {
    return new Response(JSON.stringify({ error: `Jupiter API request failed: ${(err as Error).message}` }), {
      status: 502,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const respHeaders = new Headers(response.headers);
  if (req.method === 'GET' && response.ok) {
    respHeaders.set('Cache-Control', 'public, max-age=2');
  }

  return new Response(response.body, {
    status: response.status,
    headers: respHeaders,
  });
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
  const origin = new URL(c.req.url).origin;
  return getTokens(c.env, chain, origin);
});

// Token logo proxy — proxies from Trust Wallet CDN through the gateway
app.get('/api/v1/dex-swap/tokens/:chain/:tokenAddress/logo', async (c) => {
  const { chain, tokenAddress } = c.req.param();
  const twUrl = logoUrl(chain, tokenAddress);
  if (!twUrl) return c.json({ error: 'Chain not supported for logo' }, 404);

  const res = await fetch(twUrl, { signal: AbortSignal.timeout(10000) });
  if (!res.ok) return c.json({ error: 'Logo not found' }, 404);

  const buf = await res.arrayBuffer();
  return c.body(buf, 200, {
    'Content-Type': res.headers.get('Content-Type') || 'image/png',
    'Cache-Control': 'public, max-age=86400, s-maxage=604800',
  });
});

// Get quote
app.get('/api/v1/dex-swap/quote', async (c) => {
  const chain = c.req.query('chain');
  if (!chain) return c.json({ error: 'Missing chain' }, 400);

  const okxChain = resolveChain(chain);
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const fromToken = c.req.query('fromToken');
  const toToken = c.req.query('toToken');
  const amount = c.req.query('amount');
  const slippage = c.req.query('slippage');

  if (!fromToken || !toToken || !amount) {
    return c.json({ error: 'Missing required parameters: fromToken, toToken, amount' }, 400);
  }

  const queryParams = new URLSearchParams({
    chainIndex: okxChain,
    fromTokenAddress: fromToken,
    toTokenAddress: toToken,
    amount,
    slippagePercent: slippage || '0.5', // default 0.5%
  });

  return proxyOkx(c.env, {
    method: 'GET',
    path: '/api/v6/dex/aggregator/quote',
    query: queryParams.toString(),
  });
});

// Build swap transaction
app.post('/api/v1/dex-swap/build-tx', async (c) => {
  const body = await c.req.json();
  const chain = body.chain;
  const okxChain = resolveChain(chain);
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const queryParams = new URLSearchParams({
    chainIndex: okxChain,
    fromTokenAddress: body.fromToken,
    toTokenAddress: body.toToken,
    amount: body.amount,
    slippagePercent: body.slippage || '0.5',
    userWalletAddress: body.fromAddress,
    swapMode: 'exactIn',
  });

  return proxyOkx(c.env, {
    method: 'GET',
    path: '/api/v6/dex/aggregator/swap',
    query: queryParams.toString(),
  });
});

// Build approval transaction (v6: GET /approve-transaction)
app.post('/api/v1/dex-swap/build-approve', async (c) => {
  const body = await c.req.json();
  const chain = body.chain;
  const okxChain = resolveChain(chain);
  if (!okxChain) return c.json({ error: `Unsupported chain: ${chain}` }, 400);

  const queryParams = new URLSearchParams({
    chainIndex: okxChain,
    tokenContractAddress: body.token,
    approveAmount: body.amount || '115792089237316195423570985008687907853269984665640564039457584007913129639935', // MaxUint256
  });

  return proxyOkx(c.env, {
    method: 'GET',
    path: '/api/v6/dex/aggregator/approve-transaction',
    query: queryParams.toString(),
  });
});

// ---------------------------------------------------------------------------
// Jupiter Swap API v2 routes (Solana)
// ---------------------------------------------------------------------------

// Jupiter: Get quote + unsigned transaction
app.get('/api/v1/jupiter/order', async (c) => {
  const inputMint = c.req.query('inputMint');
  const outputMint = c.req.query('outputMint');
  const amount = c.req.query('amount');
  const taker = c.req.query('taker');

  if (!inputMint || !outputMint || !amount || !taker) {
    return c.json({ error: 'Missing required parameters: inputMint, outputMint, amount, taker' }, 400);
  }

  const queryParams = new URLSearchParams({
    inputMint,
    outputMint,
    amount,
    taker,
  });

  const slippageBps = c.req.query('slippageBps');
  if (slippageBps) {
    queryParams.set('slippageBps', slippageBps);
  }

  const swapMode = c.req.query('swapMode');
  if (swapMode) {
    queryParams.set('swapMode', swapMode);
  }

  const dynamicSlippage = c.req.query('dynamicSlippage');
  if (dynamicSlippage) {
    queryParams.set('dynamicSlippage', dynamicSlippage);
  }

  return proxyJupiter(c.env, {
    method: 'GET',
    path: '/order',
    query: queryParams.toString(),
  });
});

// Jupiter: Execute signed transaction
app.post('/api/v1/jupiter/execute', async (c) => {
  let body: Record<string, unknown>;
  try {
    body = await c.req.json();
  } catch {
    return c.json({ error: 'Invalid JSON body' }, 400);
  }

  if (typeof body !== 'object' || body === null || !body.signedTransaction || !body.requestId) {
    return c.json({ error: 'Missing required fields: signedTransaction, requestId' }, 400);
  }

  return proxyJupiter(c.env, {
    method: 'POST',
    path: '/execute',
    body: JSON.stringify(body),
  });
});

// Jupiter: Get token list (Jupiter Token API V2)
app.get('/api/v1/jupiter/tokens', async (c) => {
  // Get verified tokens via Token API V2 tag endpoint
  return proxyJupiter(c.env, {
    method: 'GET',
    path: '/tag',
    query: 'query=verified',
    baseUrl: c.env.JUPITER_TOKENS_BASE_URL,
  });
});

// ---------------------------------------------------------------------------
// Export for Cloudflare Worker
// ---------------------------------------------------------------------------
const openapiSpec = () => {
  const chains = CHAIN_REGISTRY
    .filter(c => c.okxChainIndex && SUPPORTED_CHAINS.has(c.shortName))
    .flatMap(c => [c.shortName, c.caip2]);
  return {
    openapi: '3.0.3',
    info: {
      title: 'ZeroWallet DEX Swap Gateway',
      description: '代理 OKX DEX API v6，为钱包客户端提供统一的 DEX 聚合交易接口。所有请求通过 Cloudflare Workers 签名后转发到 OKX。',
      version: '1.0.0',
    },
    servers: [
      { url: 'https://dex-swap.bithub.pro', description: 'Production' },
      { url: 'http://localhost:8787', description: 'Local dev' },
    ],
    paths: {
      '/api/v1/health': {
        get: {
          summary: '健康检查',
          tags: ['System'],
          responses: {
            '200': {
              description: '服务正常',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/HealthResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/dex-swap/tokens': {
        get: {
          summary: '获取代币列表',
          description: '获取指定链上支持的代币列表。结果会缓存（默认60s）。tokenLogoUrl 通过网关代理（Trust Wallet CDN），减少客户端对外部 CDN 的直接依赖。',
          tags: ['DEX Swap'],
          parameters: [
            {
              name: 'chain', in: 'query', required: true,
              schema: { type: 'string', enum: chains },
              description: '链标识', example: 'eth',
            },
          ],
          responses: {
            '200': {
              description: '代币列表',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/TokenListResponse' },
                },
              },
            },
            '400': {
              description: '缺少 chain 参数或不支持的链',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/dex-swap/tokens/{chain}/{tokenAddress}/logo': {
        get: {
          summary: '获取代币 logo',
          description: '代理代币 logo 图片（Trust Wallet CDN）。返回图片字节数据，附带边缘缓存。',
          tags: ['DEX Swap'],
          parameters: [
            {
              name: 'chain', in: 'path', required: true,
              schema: { type: 'string' },
              description: '链短名称', example: 'eth',
            },
            {
              name: 'tokenAddress', in: 'path', required: true,
              schema: { type: 'string' },
              description: '代币合约地址', example: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
            },
          ],
          responses: {
            '200': {
              description: 'Logo 图片 (PNG)',
              content: { 'image/png': {} },
            },
            '404': {
              description: 'Logo 未找到或链不支持',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/dex-swap/quote': {
        get: {
          summary: '获取报价',
          description: '获取代币兑换的最优报价。',
          tags: ['DEX Swap'],
          parameters: [
            {
              name: 'chain', in: 'query', required: true,
              schema: { type: 'string', enum: chains },
              description: '链标识', example: 'eth',
            },
            {
              name: 'fromToken', in: 'query', required: true,
              schema: { type: 'string' },
              description: '卖出代币合约地址', example: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE',
            },
            {
              name: 'toToken', in: 'query', required: true,
              schema: { type: 'string' },
              description: '买入代币合约地址', example: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
            },
            {
              name: 'amount', in: 'query', required: true,
              schema: { type: 'string' },
              description: '卖出数量（最小单位）', example: '10000000000000000000',
            },
            {
              name: 'slippage', in: 'query', required: false,
              schema: { type: 'string', default: '0.5' },
              description: '滑点百分比', example: '0.5',
            },
          ],
          responses: {
            '200': {
              description: '报价数据',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/QuoteResponse' },
                },
              },
            },
            '400': {
              description: '参数校验失败',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/dex-swap/build-tx': {
        post: {
          summary: '构建交易',
          description: '构建代币兑换的 Swap 交易数据。',
          tags: ['DEX Swap'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: { $ref: '#/components/schemas/BuildTxRequest' },
              },
            },
          },
          responses: {
            '200': {
              description: 'Swap 交易数据',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/SwapResponse' },
                },
              },
            },
            '400': {
              description: '不支持的链',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/dex-swap/build-approve': {
        post: {
          summary: '构建授权交易',
          description: '构建代币授权（Approve）的交易数据，默认授权最大额度（MaxUint256）。',
          tags: ['DEX Swap'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: { $ref: '#/components/schemas/BuildApproveRequest' },
              },
            },
          },
          responses: {
            '200': {
              description: '授权交易数据',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/ApproveResponse' },
                },
              },
            },
            '400': {
              description: '不支持的链',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/jupiter/order': {
        get: {
          summary: '获取 Jupiter 报价和交易',
          description: '通过 Jupiter Swap API v2 获取 Solana 链上代币兑换的报价和未签名交易。',
          tags: ['Jupiter'],
          parameters: [
            {
              name: 'inputMint', in: 'query', required: true,
              schema: { type: 'string' },
              description: '输入代币的 Mint 地址', example: 'So11111111111111111111111111111111111111112',
            },
            {
              name: 'outputMint', in: 'query', required: true,
              schema: { type: 'string' },
              description: '输出代币的 Mint 地址', example: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
            },
            {
              name: 'amount', in: 'query', required: true,
              schema: { type: 'string' },
              description: '输入数量（最小单位）', example: '100000000',
            },
            {
              name: 'taker', in: 'query', required: true,
              schema: { type: 'string' },
              description: '用户钱包公钥', example: 'Gg7YdKqP7P8KqV3Q5ZxJ9X8L7s5T2p1Bv3c4D5e6F7g8h9j0k1l2m3n4o5p6',
            },
            {
              name: 'slippageBps', in: 'query', required: false,
              schema: { type: 'string' },
              description: '滑点（基点，如 50 = 0.5%）', example: '50',
            },
            {
              name: 'swapMode', in: 'query', required: false,
              schema: { type: 'string', enum: ['ExactIn', 'ExactOut'], default: 'ExactIn' },
              description: '交易模式', example: 'ExactIn',
            },
            {
              name: 'dynamicSlippage', in: 'query', required: false,
              schema: { type: 'boolean' },
              description: '是否启用动态滑点',
            },
          ],
          responses: {
            '200': {
              description: 'Jupiter 订单数据（含报价和未签名交易）',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/JupiterOrderResponse' },
                },
              },
            },
            '400': {
              description: '参数校验失败',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/jupiter/tokens': {
        get: {
          summary: '获取 Jupiter 支持的 Solana 代币列表',
          description: '获取 Jupiter Token API v2 验证过的 Solana 链上代币列表。',
          tags: ['Jupiter'],
          responses: {
            '200': {
              description: '代币列表',
              content: {
                'application/json': {
                  schema: {
                    type: 'array',
                    items: { $ref: '#/components/schemas/JupiterTokenData' },
                  },
                },
              },
            },
            '502': {
              description: '上游 API 不可达',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
      '/api/v1/jupiter/execute': {
        post: {
          summary: '执行 Jupiter Swap 交易',
          description: '提交已签名的 Solana 交易到 Jupiter 执行。',
          tags: ['Jupiter'],
          requestBody: {
            required: true,
            content: {
              'application/json': {
                schema: { $ref: '#/components/schemas/JupiterExecuteRequest' },
              },
            },
          },
          responses: {
            '200': {
              description: '执行结果',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/JupiterExecuteResponse' },
                },
              },
            },
            '400': {
              description: '参数校验失败',
              content: {
                'application/json': {
                  schema: { $ref: '#/components/schemas/GatewayErrorResponse' },
                },
              },
            },
          },
        },
      },
    },
    components: {
      schemas: {
        // ---- Gateway ----
        HealthResponse: {
          type: 'object',
          properties: {
            status: { type: 'string', example: 'healthy' },
            service: { type: 'string', example: 'dex-swap-gateway' },
            timestamp: { type: 'string', format: 'date-time', example: '2026-05-03T08:00:00.000Z' },
          },
        },
        GatewayErrorResponse: {
          type: 'object',
          properties: {
            error: { type: 'string', example: 'Missing chain parameter' },
          },
        },
        BuildTxRequest: {
          type: 'object',
          required: ['chain', 'fromToken', 'toToken', 'amount', 'fromAddress'],
          properties: {
            chain: { type: 'string', enum: chains, description: '链标识', example: 'eth' },
            fromToken: { type: 'string', description: '卖出代币合约地址', example: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE' },
            toToken: { type: 'string', description: '买入代币合约地址', example: '0xdAC17F958D2ee523a2206206994597C13D831ec7' },
            amount: { type: 'string', description: '卖出数量（最小单位）', example: '10000000000000000000' },
            fromAddress: { type: 'string', description: '用户钱包地址', example: '0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B' },
            slippage: { type: 'string', default: '0.5', description: '滑点百分比', example: '0.5' },
          },
        },
        BuildApproveRequest: {
          type: 'object',
          required: ['chain', 'token'],
          properties: {
            chain: { type: 'string', enum: chains, description: '链标识', example: 'eth' },
            token: { type: 'string', description: '代币合约地址', example: '0xdAC17F958D2ee523a2206206994597C13D831ec7' },
            amount: { type: 'string', description: '授权数量（最小单位，默认 MaxUint256）', example: '115792089237316195423570985008687907853269984665640564039457584007913129639935' },
          },
        },
        // ---- OKX Response Wrapper ----
        OkxResponse: {
          type: 'object',
          properties: {
            code: { type: 'string', example: '0' },
            msg: { type: 'string', example: '' },
            data: {
              type: 'array',
              items: { type: 'object', additionalProperties: true },
            },
          },
        },
        // ---- Token List ----
        TokenListResponse: {
          type: 'object',
          properties: {
            code: { type: 'string', example: '0' },
            msg: { type: 'string', example: '' },
            data: {
              type: 'array',
              items: { $ref: '#/components/schemas/TokenData' },
            },
          },
        },
        TokenData: {
          type: 'object',
          properties: {
            decimals: { type: 'string', example: '18' },
            tokenContractAddress: { type: 'string', example: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE' },
            tokenLogoUrl: { type: 'string', example: 'https://static.okx.com/cdn/wallet/logo/ETH-20220328.png' },
            tokenName: { type: 'string', example: 'Ethereum' },
            tokenSymbol: { type: 'string', example: 'ETH' },
          },
        },
        // ---- Quote ----
        QuoteResponse: {
          type: 'object',
          properties: {
            code: { type: 'string', example: '0' },
            msg: { type: 'string', example: '' },
            data: {
              type: 'array',
              items: { $ref: '#/components/schemas/QuoteData' },
            },
          },
        },
        QuoteData: {
          type: 'object',
          properties: {
            chainIndex: { type: 'string', example: '1' },
            routerResult: { $ref: '#/components/schemas/RouterResult' },
            dexRouterList: {
              type: 'array',
              items: { $ref: '#/components/schemas/DexRouter' },
            },
            estimateGasFee: { type: 'string', example: '30000' },
            fromToken: { $ref: '#/components/schemas/TokenInfo' },
            toToken: { $ref: '#/components/schemas/TokenInfo' },
            fromTokenAmount: { type: 'string', example: '10000000000000000000' },
            toTokenAmount: { type: 'string', example: '5000000000' },
            priceImpactPercent: { type: 'string', example: '0.05' },
            router: { type: 'string', example: '0x...' },
            swapMode: { type: 'string', example: 'exactIn' },
            tradeFee: { type: 'string', example: '0' },
          },
        },
        RouterResult: {
          type: 'object',
          properties: {
            chainIndex: { type: 'string', example: '1' },
            dexRouterList: {
              type: 'array',
              items: { $ref: '#/components/schemas/DexRouter' },
            },
            estimateGasFee: { type: 'string' },
            fromToken: { $ref: '#/components/schemas/TokenInfo' },
            toToken: { $ref: '#/components/schemas/TokenInfo' },
            fromTokenAmount: { type: 'string' },
            toTokenAmount: { type: 'string' },
            priceImpactPercent: { type: 'string' },
            router: { type: 'string' },
            swapMode: { type: 'string' },
            tradeFee: { type: 'string' },
          },
        },
        DexRouter: {
          type: 'object',
          properties: {
            dexProtocol: { $ref: '#/components/schemas/DexProtocol' },
            fromToken: { $ref: '#/components/schemas/TokenInfo' },
            fromTokenIndex: { type: 'string' },
            toToken: { $ref: '#/components/schemas/TokenInfo' },
            toTokenIndex: { type: 'string' },
          },
        },
        DexProtocol: {
          type: 'object',
          properties: {
            dexName: { type: 'string', example: 'Uniswap_V3' },
            percent: { type: 'string', example: '100' },
          },
        },
        TokenInfo: {
          type: 'object',
          properties: {
            decimal: { type: 'string', example: '18' },
            tokenContractAddress: { type: 'string', example: '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE' },
            tokenSymbol: { type: 'string', example: 'ETH' },
            tokenUnitPrice: { type: 'string', example: '3000.50' },
            isHoneyPot: { type: 'boolean', example: false },
            taxRate: { type: 'string', example: '0' },
          },
        },
        // ---- Swap (build-tx) ----
        SwapResponse: {
          type: 'object',
          properties: {
            code: { type: 'string', example: '0' },
            msg: { type: 'string', example: '' },
            data: {
              type: 'array',
              items: { $ref: '#/components/schemas/SwapResultItem' },
            },
          },
        },
        SwapResultItem: {
          type: 'object',
          properties: {
            routerResult: { $ref: '#/components/schemas/RouterResult' },
            tx: { $ref: '#/components/schemas/TransactionData' },
          },
        },
        TransactionData: {
          type: 'object',
          properties: {
            data: { type: 'string', example: '0x...' },
            from: { type: 'string', example: '0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B' },
            to: { type: 'string', example: '0x...' },
            value: { type: 'string', example: '0' },
            gas: { type: 'string', example: '300000' },
            gasPrice: { type: 'string', example: '10000000000' },
            maxPriorityFeePerGas: { type: 'string', example: '100000000' },
            maxSpendAmount: { type: 'string', example: '10000000000000000000' },
            minReceiveAmount: { type: 'string', example: '4900000000' },
            slippagePercent: { type: 'string', example: '0.5' },
            signatureData: {
              type: 'array',
              items: { type: 'string' },
            },
          },
        },
        // ---- Approve (build-approve) ----
        ApproveResponse: {
          type: 'object',
          properties: {
            code: { type: 'string', example: '0' },
            msg: { type: 'string', example: '' },
            data: {
              type: 'array',
              items: { $ref: '#/components/schemas/ApproveTransactionData' },
            },
          },
        },
        ApproveTransactionData: {
          type: 'object',
          properties: {
            dexContractAddress: { type: 'string', example: '0x...' },
            data: { type: 'string', example: '0x095ea7b3000000000000000000000000...' },
            gasLimit: { type: 'string', example: '50000' },
            gasPrice: { type: 'string', example: '110000000' },
          },
        },
        // ---- Jupiter ----
        JupiterOrderResponse: {
          type: 'object',
          properties: {
            inputMint: { type: 'string', example: 'So11111111111111111111111111111111111111112' },
            inAmount: { type: 'string', example: '100000000' },
            outputMint: { type: 'string', example: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v' },
            outAmount: { type: 'string', example: '249850' },
            otherAmountThreshold: { type: 'string', example: '249725' },
            priceImpactPct: { type: 'string', example: '0.060000000000000000' },
            slippageBps: { type: 'integer', example: 50 },
            routePlan: {
              type: 'array',
              items: {
                type: 'object',
                properties: {
                  swapInfo: { $ref: '#/components/schemas/JupiterSwapInfo' },
                  percent: { type: 'integer', example: 100 },
                },
              },
            },
            requestId: { type: 'string', example: 'uuid-string' },
            transaction: { type: 'string', description: 'Base64 编码的未签名 Solana 交易', example: 'base64...' },
          },
        },
        JupiterSwapInfo: {
          type: 'object',
          properties: {
            ammKey: { type: 'string', example: '...' },
            label: { type: 'string', example: 'Raydium' },
            inputMint: { type: 'string' },
            outputMint: { type: 'string' },
            inAmount: { type: 'string' },
            outAmount: { type: 'string' },
            feeAmount: { type: 'string' },
            feeMint: { type: 'string' },
          },
        },
        JupiterExecuteRequest: {
          type: 'object',
          required: ['signedTransaction', 'requestId'],
          properties: {
            signedTransaction: {
              type: 'string',
              description: '客户端签名后的 Base64 编码 Solana 交易',
              example: 'AQAAAAAAAAAAAAAAAAAAAA...',
            },
            requestId: {
              type: 'string',
              description: '从 /jupiter/order 返回的 requestId',
              example: 'uuid-string',
            },
          },
        },
        JupiterExecuteResponse: {
          type: 'object',
          properties: {
            signature: { type: 'string', description: '链上交易签名', example: '5KtPn3...' },
            status: { type: 'string', enum: ['Success', 'Failed'], example: 'Success' },
            error: { type: 'string', nullable: true, example: null },
          },
        },
        JupiterTokenData: {
          type: 'object',
          description: 'Jupiter 支持的 Solana 代币信息',
          properties: {
            address: { type: 'string', description: '代币 Mint 地址', example: 'So11111111111111111111111111111111111111112' },
            name: { type: 'string', description: '代币名称', example: 'Wrapped SOL' },
            symbol: { type: 'string', description: '代币符号', example: 'SOL' },
            decimals: { type: 'integer', description: '精度', example: 9 },
            logoURI: { type: 'string', description: '代币图标 URL', example: 'https://example.com/sol.png' },
            tags: {
              type: 'array',
              items: { type: 'string' },
              description: '代币标签',
              example: ['wormhole', 'native'],
            },
            verified: { type: 'boolean', description: '是否经过验证', example: true },
          },
        },
      },
    },
  };
};

// ---------------------------------------------------------------------------
// Swagger UI HTML (rendered from CDN)
// ---------------------------------------------------------------------------
const swaggerHtml = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>ZeroWallet DEX Swap Gateway - API Docs</title>
  <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@5.18.3/swagger-ui.css" />
</head>
<body>
  <div id="swagger-ui"></div>
  <script src="https://unpkg.com/swagger-ui-dist@5.18.3/swagger-ui-bundle.js" crossorigin></script>
  <script>
    SwaggerUIBundle({
      url: '/api/v1/openapi.json',
      dom_id: '#swagger-ui',
      deepLinking: true,
      presets: [
        SwaggerUIBundle.presets.apis,
        SwaggerUIBundle.SwaggerUIStandalonePreset,
      ],
      layout: 'BaseLayout',
    });
  </script>
</body>
</html>`;

// OpenAPI spec endpoint
app.get('/api/v1/openapi.json', (c) => {
  return c.json(openapiSpec());
});

// Swagger UI
app.get('/api/v1/docs', (c) => {
  return c.html(swaggerHtml);
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
export { signAsync, resolveChain, SUPPORTED_CHAINS };
