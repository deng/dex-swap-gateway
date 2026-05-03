# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
npm run dev       # Start local Wrangler dev server on :8787
npm run deploy    # Deploy to Cloudflare Workers (uses dotenv for CLOUDFLARE_API_TOKEN)
npm test          # Run all tests via Vitest (no network needed)
npm run typecheck # Type-check with tsc --noEmit
npm run test:watch # Watch mode for tests
npm run generate-sdk # Regenerate Flutter SDK from live OpenAPI spec
```

## Key Architecture

**Single-file Cloudflare Worker** (`src/index.ts`) that proxies OKX DEX API v6 requests with HMAC-SHA256 signing. Wallet endpoints (Flutter) call this gateway instead of OKX directly, avoiding credential exposure in mobile binaries.

### Data flow

```
Flutter App → Gateway (Hono) → HMAC sign → OKX DEX API v6
                 ↑
           env vars: API Key, Secret, Passphrase, Project ID
```

### Route layout (all under `/api/v1/`)

| Method | Path                  | Proxies to OKX v6                              |
|--------|-----------------------|-------------------------------------------------|
| GET    | /health               | (local, no proxy)                               |
| GET    | /openapi.json         | (OpenAPI 3.0 spec, local)                       |
| GET    | /docs                 | (Swagger UI, local)                             |
| GET    | /dex-swap/tokens      | GET /api/v6/dex/aggregator/all-tokens           |
| GET    | /dex-swap/quote       | GET /api/v6/dex/aggregator/quote                |
| POST   | /dex-swap/build-tx    | GET /api/v6/dex/aggregator/swap                 |
| POST   | /dex-swap/build-approve | GET /api/v6/dex/aggregator/approve-transaction |

Note: build-tx and build-approve remain POST for the Flutter client, but the gateway translates them to GET when proxying to OKX.

### Chain mapping

`CHAIN_MAP` in `src/index.ts` translates wallet chain identifiers to OKX `chainIndex` values (v6). The mapping only covers 9 chains:

| Wallet key | OKX chainIndex | Network         |
|------------|----------------|-----------------|
| eth        | 1              | Ethereum        |
| bsc        | 56             | BSC             |
| polygon    | 137            | Polygon         |
| base       | 8453           | Base            |
| arbitrum   | 42161          | Arbitrum        |
| optimism   | 10             | Optimism        |
| sui        | 784            | Sui             |
| ton        | 607            | TON             |
| trx        | 195            | Tron            |

OKX chainIndex values are **standard EVM chain IDs** for EVM chains (not custom OKX IDs). Adding a new chain requires adding an entry here, a test for it, and updating the OpenAPI spec's `chains` array.

### Caching

Token list responses are cached in-memory via `tokenCache` (Map<string, CacheEntry>) with configurable TTL (`TOKEN_CACHE_TTL` env var, default 60s). Per-request responses get a `Cache-Control: public, max-age=2` header. The cache is per-worker-instance (not shared across Workers).

### Signing

`signAsync()` implements OKX's HMAC-SHA256 signature: `<timestamp><method><requestPath><body>` signed with the secret key, base64-encoded. Used for every outbound request to OKX.

### CORS

Wildcard CORS (`origin: *`) enabled for all routes — designed for mobile wallet clients that don't send preflight.

### Testing pattern

Tests in `test/gateway.test.ts` use Hono's `app.fetch()` directly (no server needed). Mock `Env` objects provide test credentials. Tests cover: HMAC signing consistency, chain mapping, input validation (400s), CORS headers, and proxied request structure (via `vi.fn()` mock on `globalThis.fetch`). `20 tests total`.

## OpenAPI / Swagger

- Live spec: `GET /api/v1/openapi.json` (generated from CHAIN_MAP at request time)
- Swagger UI: `GET /api/v1/docs` (loaded from unpkg CDN)
- Full response types defined in `components/schemas` (18 schemas: TokenData, QuoteData, TransactionData, RouterResult, etc.)

## Generated Flutter SDK

`dex-swap-gateway-flutter/` is an auto-generated Flutter package from the live spec via `openapi-generator`:

```bash
openapi-generator generate \
  -i https://<host>/api/v1/openapi.json \
  -g dart \
  -o ./dex-swap-gateway-flutter \
  --additional-properties=pubName=dex_swap_gateway,pubVersion=1.0.0
```

**Wallet app usage** — add as a path dependency in `pubspec.yaml`:
```yaml
dependencies:
  dex_swap_gateway:
    path: ../dex-swap-gateway/dex-swap-gateway-flutter
```

Then in Dart code:
```dart
final api = DEXSwapApi();

// Get tokens
final tokens = await api.apiV1DexSwapTokensGet('eth');
for (final token in tokens!.data) {
  print('${token.tokenSymbol}: ${token.tokenName}');
}

// Get quote
final quote = await api.apiV1DexSwapQuoteGet(
  'eth',
  '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE', // ETH
  '0xdAC17F958D2ee523a2206206994597C13D831ec7',  // USDT
  '10000000000000000', // 0.01 ETH
  slippage: '0.5',
);

// Build swap tx
final tx = await api.apiV1DexSwapBuildTxPost(BuildTxRequest(
  chain: 'eth',
  fromToken: '0x...',
  toToken: '0x...',
  amount: '10000000000000000',
  fromAddress: '0x...',
));
```

Contains: DEXSwapApi + SystemApi classes, 18 model types with fromJson/toJson, auto-generated unit tests, null-safe Dart.

## Configuration

Credentials are set via `wrangler secret put` in production (not in `wrangler.toml`):
- `OKX_API_KEY`, `OKX_SECRET_KEY`, `OKX_API_PASSPHRASE`, `OKX_PROJECT_ID`
- `CLOUDFLARE_API_TOKEN` for deployment (set in `.env`, loaded by `dotenv-cli`)

Local dev uses `.env` file (run `cp -n .env.example .env` to create). Secrets go in `.dev.vars` for `wrangler dev`. `wrangler.toml` holds non-secret defaults (`OKX_BASE_URL`, `TOKEN_CACHE_TTL`).

## Notable constraints

- OKX DEX API v6 requires 5 headers: `OK-ACCESS-KEY`, `OK-ACCESS-SIGN`, `OK-ACCESS-TIMESTAMP`, `OK-ACCESS-PASSPHRASE`, `OK-ACCESS-PROJECT`
- v6 endpoints use `chainIndex` (NOT `chainId`), `slippagePercent` (NOT `slippage`), `tokenContractAddress` (NOT `tokenAddress`), `approveAmount` (NOT `amount` for approve)
- Hono + dotenv-cli are the only runtime dependencies — no other npm dependencies
- Tests import from `../src/index` at runtime (dynamic import pattern)
- `CHAIN_MAP` values are OKX v6 `chainIndex` values, **standard EVM chain IDs** (e.g. eth=1, not 43114)
