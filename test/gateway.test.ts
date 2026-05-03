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
      '/api/v6/dex/aggregator/quote?chainIndex=1&fromTokenAddress=0x&toTokenAddress=0x&amount=100',
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

  it('should use correct v6 chainIndex values', async () => {
    const { CHAIN_MAP } = await import('../src/index');
    expect(CHAIN_MAP['eth']).toBe('1');
    expect(CHAIN_MAP['bsc']).toBe('56');
    expect(CHAIN_MAP['polygon']).toBe('137');
    expect(CHAIN_MAP['base']).toBe('8453');
    expect(CHAIN_MAP['arbitrum']).toBe('42161');
    expect(CHAIN_MAP['optimism']).toBe('10');
    expect(CHAIN_MAP['sui']).toBe('784');
    expect(CHAIN_MAP['ton']).toBe('607');
    expect(CHAIN_MAP['trx']).toBe('195');
  });
});

// ---------------------------------------------------------------------------
// Integration tests: HTTP endpoints
// ---------------------------------------------------------------------------
async function createApp() {
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
  const opts: RequestInit = { method };
  if (body !== undefined) {
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
  it('should use v6 API path and GET method with query params for swap', async () => {
    const originalFetch = globalThis.fetch;
    const mockFetch = vi.fn().mockResolvedValue(
      new Response(JSON.stringify({ data: 'ok' }), { status: 200 }),
    );
    globalThis.fetch = mockFetch;

    const app = await createApp();
    await app.fetch(
      mockRequest('POST', 'http://localhost/api/v1/dex-swap/build-tx', {
        chain: 'eth',
        fromToken: '0xFrom',
        toToken: '0xTo',
        amount: '1000000',
        fromAddress: '0xUser',
        slippage: '0.5',
      }),
      mockEnv,
    );

    const callUrl = mockFetch.mock.calls[0][0];
    const callOpts = mockFetch.mock.calls[0][1];

    // Verify v6 API path
    expect(callUrl).toContain('/api/v6/dex/aggregator/swap');
    // Verify GET method
    expect(callOpts.method).toBe('GET');
    // Verify query params
    expect(callUrl).toContain('chainIndex=1');
    expect(callUrl).toContain('fromTokenAddress=0xFrom');
    expect(callUrl).toContain('toTokenAddress=0xTo');
    expect(callUrl).toContain('amount=1000000');
    expect(callUrl).toContain('slippagePercent=0.5');
    expect(callUrl).toContain('userWalletAddress=0xUser');
    expect(callUrl).toContain('swapMode=exactIn');

    globalThis.fetch = originalFetch;
  });

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
  it('should use v6 API path and GET method with query params for approve', async () => {
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

    const callUrl = mockFetch.mock.calls[0][0];
    const callOpts = mockFetch.mock.calls[0][1];

    // Verify v6 API path
    expect(callUrl).toContain('/api/v6/dex/aggregator/approve-transaction');
    // Verify GET method
    expect(callOpts.method).toBe('GET');
    // Verify query params (v6 uses tokenContractAddress, approveAmount; no spender)
    expect(callUrl).toContain('chainIndex=1');
    expect(callUrl).toContain('tokenContractAddress=0xToken');
    expect(callUrl).toContain('approveAmount');
    expect(callUrl).not.toContain('spender');

    globalThis.fetch = originalFetch;
  });

  it('should use MaxUint256 as default approveAmount', async () => {
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

    // Verify the proxied request URL includes MaxUint256 default
    const callUrl = mockFetch.mock.calls[0][0];
    expect(callUrl).toContain('approveAmount=115792089237316195423570985008687907853269984665640564039457584007913129639935');

    globalThis.fetch = originalFetch;
  });

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

describe('OpenAPI documentation', () => {
  it('should serve OpenAPI spec at /api/v1/openapi.json', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/openapi.json'), mockEnv);
    expect(res.status).toBe(200);
    const spec = await res.json();
    expect(spec.openapi).toBe('3.0.3');
    expect(spec.info.title).toBe('ZeroWallet DEX Swap Gateway');
    expect(spec.paths['/api/v1/health']).toBeDefined();
    expect(spec.paths['/api/v1/dex-swap/tokens']).toBeDefined();
    expect(spec.paths['/api/v1/dex-swap/quote']).toBeDefined();
    expect(spec.paths['/api/v1/dex-swap/build-tx']).toBeDefined();
    expect(spec.paths['/api/v1/dex-swap/build-approve']).toBeDefined();
  });

  it('should serve Swagger UI at /api/v1/docs', async () => {
    const app = await createApp();
    const res = await app.fetch(mockRequest('GET', 'http://localhost/api/v1/docs'), mockEnv);
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text).toContain('swagger-ui');
    expect(text).toContain('ZeroWallet DEX Swap Gateway');
    expect(text).toContain('/api/v1/openapi.json');
  });
});
