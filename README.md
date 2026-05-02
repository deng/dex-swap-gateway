# DEX Swap Gateway

> ZeroWallet 的 DEX 兑换代理网关 — 为移动端提供 OKX DEX API 的 HMAC 签名代理。

## 定位

钱包端（Flutter）直接调用 OKX DEX API 需要 API Key + Secret Key + Passphrase，这些凭证不能打包进移动端二进制。本网关作为轻量代理，持有凭证，为钱包端加签转发请求。

## 技术栈

- **运行时**: Cloudflare Workers
- **语言**: TypeScript
- **框架**: Hono (轻量 Web 框架)
- **测试**: Vitest
- **部署**: Wrangler CLI

## 快速开始

```bash
# 安装依赖
npm install

# 本地开发（需先配置环境变量）
cp .env.example .env
# 编辑 .env 填入 OKX API 凭证
npm run dev

# 测试
npm test

# 类型检查
npm run typecheck
```

## 环境变量

| 变量 | 说明 | 来源 |
|------|------|------|
| `OKX_API_KEY` | OKX API Key | OKX 开发者后台 → API |
| `OKX_SECRET_KEY` | OKX Secret Key | 创建 API Key 时生成 |
| `OKX_API_PASSPHRASE` | API 通行口令 | 创建 API Key 时设置 |
| `OKX_PROJECT_ID` | 项目 ID | OKX 开发者后台 |
| `OKX_BASE_URL` | OKX API 地址（默认 `https://www.okx.com`） | — |
| `TOKEN_CACHE_TTL` | 代币列表缓存 TTL（秒，默认 `60`） | — |

### 配置方式

**本地开发**: 创建 `.env` 文件（参考 `.env.example`）

**生产环境**: 通过 `wrangler secret` 设置：

```bash
npx wrangler secret put OKX_API_KEY
npx wrangler secret put OKX_SECRET_KEY
npx wrangler secret put OKX_API_PASSPHRASE
npx wrangler secret put OKX_PROJECT_ID
```

## API 端点

所有端点前缀: `/api/v1/dex-swap`

### `GET /health`

健康检查。

```bash
curl https://dex-swap-gateway.dev.zerowallet.io/api/v1/health
```

```json
{ "status": "healthy", "service": "dex-swap-gateway", "timestamp": "..." }
```

### `GET /tokens?chain={chain}`

获取指定链的代币列表。结果缓存 60s。

```bash
curl 'https://dex-swap-gateway.dev.zerowallet.io/api/v1/dex-swap/tokens?chain=eth'
```

| 参数 | 说明 | 示例 |
|------|------|------|
| `chain` | 链标识 | `eth`, `bsc`, `sol`, `sui` |

### `GET /quote?chain={chain}&fromToken={address}&toToken={address}&amount={wei}&slippage={bps}`

获取报价。

| 参数 | 说明 | 默认 |
|------|------|------|
| `chain` | 链标识 | — |
| `fromToken` | 支付代币地址 | — |
| `toToken` | 接收代币地址 | — |
| `amount` | 支付金额（原始单位含 decimals） | — |
| `slippage` | 滑点（bps，如 50=0.5%） | `50` |

```bash
curl 'https://dex-swap-gateway.dev.zerowallet.io/api/v1/dex-swap/quote?chain=eth&fromToken=0x...&toToken=0x...&amount=1000000000000000000&slippage=50'
```

### `POST /build-tx`

构建 Swap 交易数据。

```json
// Request
{
  "chain": "eth",
  "fromToken": "0x...",
  "toToken": "0x...",
  "amount": "1000000000000000000",
  "fromAddress": "0x...",
  "slippage": "50"
}

// Response (透传 OKX)
{
  "code": "0",
  "data": [{
    "tx": { /* 交易数据，Flutter 端签名后广播 */ }
  }]
}
```

### `POST /build-approve`

构建代币授权交易。

```json
// Request
{
  "chain": "eth",
  "token": "0x...",
  "spender": "0x...",
  "amount": "115792089237316195423570985008687907853269984665640564039457584007913129639935"
}
```

## 链映射

网关内部将钱包链标识映射为 OKX 的 chainId：

| 钱包链 | OKX chainId |
|--------|-------------|
| `eth` | `43114` |
| `bsc` | `56` |
| `polygon` | `137` |
| `base` | `8453` |
| `arbitrum` | `42161` |
| `optimism` | `10` |
| `sui` | `501` |
| `ton` | `607` |
| `trx` | `195` |

## 开发指南

### 目录结构

```
dex-swap/
├── src/
│   └── index.ts        # Worker 入口：路由 + OKX 代理逻辑
├── test/
│   └── gateway.test.ts  # 单元测试（HMAC 签名、链映射）
├── wrangler.toml        # CF Workers 配置
├── package.json
├── tsconfig.json
├── README.md
└── .env.example         # 环境变量模板
```

### 本地开发流程

```bash
# 1. 启动本地 dev server（端口 8787）
npm run dev

# 2. 测试端点
curl http://localhost:8787/api/v1/health
curl 'http://localhost:8787/api/v1/dex-swap/tokens?chain=eth'

# 3. 每次修改后自动重载
```

### 测试

```bash
# 单元测试（不依赖网络）
npm test

# 手动端到端测试（需 OKX 凭证）
curl 'http://localhost:8787/api/v1/dex-swap/quote?chain=eth&fromToken=0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2&toToken=0xdAC17F958D2ee523a2206206994597C13D831ec7&amount=10000000000000000'
```

## 部署

```bash
# 部署到 Cloudflare
npm run deploy

# 通过 wrangler 指定环境
npx wrangler deploy --env production
```

## 与钱包端对接

钱包端（Flutter）通过编译常量配置网关地址：

```dart
// 生产环境
const SWAP_GATEWAY_URL = 'https://dex-swap-gateway.dev.zerowallet.io/api/v1';

// OKX 聚合器客户端通过此地址调用
class OkxDexAggregator implements DexAggregator {
  final String baseUrl;

  Future<QuoteResult> getQuote(QuoteRequest request) async {
    final uri = Uri.parse('$baseUrl/dex-swap/quote').replace(queryParameters: {
      'chain': request.chain.name,
      'fromToken': request.fromToken,
      'toToken': request.toToken,
      'amount': request.amount.toString(),
      'slippage': request.slippage?.toString(),
    });
    final response = await http.get(uri);
    return QuoteResult.fromJson(response.body);
  }
}
```
