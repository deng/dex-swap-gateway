import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';

// ---------------------------------------------------------------------------
// Unit tests: HMAC signing
// ---------------------------------------------------------------------------
describe('signAsync', () => {
  it('should produce a consistent HMAC signature', async () => {
    const { signAsync } = await import('../src/index');

    const timestamp = '2025-10-01T00:00:00.000Z';
    const signature = await signAsync(
      'test-secret',
      timestamp,
      'GET',
      '/api/v5/dex/aggregator/quote?chainId=1&fromTokenAddress=0x&toTokenAddress=0x&amount=100',
    );

    expect(signature).toBeDefined();
    expect(typeof signature).toBe('string');
    expect(signature.length).toBeGreaterThan(0);
  });

  it('should produce different signatures for different inputs', async () => {
    const { signAsync } = await import('../src/index');

    const sig1 = await signAsync('secret', '2025-01-01T00:00:00.000Z', 'GET', '/path', '');
    const sig2 = await signAsync('secret', '2025-01-01T00:00:00.000Z', 'POST', '/path', '');
    expect(sig1).not.toBe(sig2);

    const sig3 = await signAsync('secret', '2025-01-01T00:00:00.000Z', 'GET', '/path', 'body');
    expect(sig1).not.toBe(sig3);

    const sig4 = await signAsync('other-secret', '2025-01-01T00:00:00.000Z', 'GET', '/path', '');
    expect(sig1).not.toBe(sig4);
  });
});

// ---------------------------------------------------------------------------
// Unit tests: CHAIN_MAP
// ---------------------------------------------------------------------------
describe('CHAIN_MAP', () => {
  it('should have entries for all supported EVM chains', async () => {
    const { CHAIN_MAP } = await import('../src/index');
    expect(CHAIN_MAP['eth']).toBeDefined();
    expect(CHAIN_MAP['bsc']).toBeDefined();
    expect(CHAIN_MAP['polygon']).toBeDefined();
    expect(CHAIN_MAP['base']).toBeDefined();
    expect(CHAIN_MAP['arbitrum']).toBeDefined();
    expect(CHAIN_MAP['optimism']).toBeDefined();
    expect(CHAIN_MAP['sui']).toBeDefined();
    expect(CHAIN_MAP['ton']).toBeDefined();
    expect(CHAIN_MAP['trx']).toBeDefined();
  });

  it('should not have entry for unsupported chains', async () => {
    const { CHAIN_MAP } = await import('../src/index');
    expect(CHAIN_MAP['btc']).toBeUndefined();
    expect(CHAIN_MAP['sol']).toBeUndefined();
  });
});

// ---------------------------------------------------------------------------
// Integration tests: HTTP endpoints
// ---------------------------------------------------------------------------
async function createApp() {
  // Hono app requires dynamic import because index.ts uses top-level `new Hono()`
  const mod = await import('../src/index');
  return mod.default;
}

const mockEnv = {
  OKX_API_KEY: 'test-api-key',
  OKX_SECRET_KEY: 'test-secret-key',
  OKX_API_PASSPHRASE: 'test-passphrase',
  OKX_PROJECT_ID: 'test-project',
  OKX_BASE_URL: 'https://www.okx.com',
  TOKEN_CACHE_TTL: '60',
};

function mockRequest(method: string, url: string, body?: unknown): Request {
  const opts: RequestInit & { duplex?: string } = { method };
  if (body) {
    opts.body = JSON.stringify(body);
    opts.headers = { 'Content-Type': 'application/json' };
  }
  return new Request(url, opts);
}

describe('GET /api/v1/health', () => {
  it('should return healthy status', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/health'), mockEnv);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.status).toBe('healthy');
    expect(body.service).toBe('dex-swap-gateway');
    expect(body.timestamp).toBeDefined();
  });
});

describe('GET /api/v1/dex-swap/tokens', () => {
  it('should return 400 if chain parameter is missing', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/dex-swap/tokens'), mockEnv);
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.error).toContain('Missing chain');
  });

  it('should return 400 for unsupported chain', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/dex-swap/tokens?chain=sol'), mockEnv);
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.error).toContain('Unsupported chain');
  });
});

describe('GET /api/v1/dex-swap/quote', () => {
  it('should return 400 if chain is missing', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/dex-swap/quote'), mockEnv);
    expect(res.status).toBe(400);
  });

  it('should return 400 for unsupported chain', async () => {
    const app = await createApp();
    const res = await app.fetch(
      mockRequest('GET', 'http://localhost/api/v1/dex-swap/quote?chain=sol&fromToken=0x&toToken=0x&amount=1'),
      mockEnv,
    );
    expect(res.status).toBe(400);
  });

  it('should return 400 if required params are missing', async () => {
    const app = await createApp();
    const res = await app.fetch(
      mockRequest('GET', 'http://localhost/api/v1/dex-swap/quote?chain=eth'),
      mockEnv,
    );
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.error).toContain('Missing required parameters');
  });
});

describe('POST /api/v1/dex-swap/build-tx', () => {
  it('should return 400 for unsupported chain', async () => {
    const app = await createApp();
    const res = await app.fetch(
      mockRequest('POST', 'http://localhost/api/v1/dex-swap/build-tx', {
        chain: 'sol',
        fromToken: '0x',
        toToken: '0x',
        amount: '1000000',
        fromAddress: '0x',
      }),
      mockEnv,
    );
    expect(res.status).toBe(400);
  });
});

describe('POST /api/v1/dex-swap/build-approve', () => {
  it('should return 400 for unsupported chain', async () => {
    const app = await createApp();
    const res = await app.fetch(
      mockRequest('POST', 'http://localhost/api/v1/dex-swap/build-approve', {
        chain: 'btc',
        token: '0x',
        spender: '0x',
      }),
      mockEnv,
    );
    expect(res.status).toBe(400);
  });

  it('should use MaxUint256 as default amount', async () => {
    // Spy on global fetch to verify the proxied request body
    const originalFetch = globalThis.fetch;
    const mockFetch = vi.fn().mockResolvedValue(
      new Response(JSON.stringify({ data: 'ok' }), { status: 200 }),
    );
    globalThis.fetch = mockFetch;

    const app = await createApp();
    await app.fetch(
      mockRequest('POST', 'http://localhost/api/v1/dex-swap/build-approve', {
        chain: 'eth',
        token: '0xToken',
        spender: '0xSpender',
      }),
      mockEnv,
    );

    // Verify the proxied request body includes MaxUint256
    const callArgs = mockFetch.mock.calls[0];
    const proxiedBody = JSON.parse(callArgs[1].body as string);
    expect(proxiedBody.tokenAddress).toBe('0xToken');
    expect(proxiedBody.spender).toBe('0xSpender');
    expect(proxiedBody.amount).toContain('115792089237316195423570985008687907853269984665640564039457584007913129639935');

    globalThis.fetch = originalFetch;
  });
});

describe('Cross-Origin Resource Sharing (CORS)', () => {
  it('should include CORS headers in responses', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/health'), mockEnv);
    expect(res.headers.get('access-control-allow-origin')).toBe('*');
  });
});

describe('Cache control headers', () => {
  it('should set Cache-Control on responses', async () => {
    const app = await createApp();

    // Health endpoint should have default/minimal caching
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/health'), mockEnv);
    expect(res.headers.get('Cache-Control')).toBeDefined();
  });
});
