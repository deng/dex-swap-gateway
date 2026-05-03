# dex_swap_gateway.api.DEXSwapApi

## Load the API package
```dart
import 'package:dex_swap_gateway/api.dart';
```

All URIs are relative to *https://dex-swap.bithub.pro*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1DexSwapBuildApprovePost**](DEXSwapApi.md#apiv1dexswapbuildapprovepost) | **POST** /api/v1/dex-swap/build-approve | 构建授权交易
[**apiV1DexSwapBuildTxPost**](DEXSwapApi.md#apiv1dexswapbuildtxpost) | **POST** /api/v1/dex-swap/build-tx | 构建交易
[**apiV1DexSwapQuoteGet**](DEXSwapApi.md#apiv1dexswapquoteget) | **GET** /api/v1/dex-swap/quote | 获取报价
[**apiV1DexSwapTokensGet**](DEXSwapApi.md#apiv1dexswaptokensget) | **GET** /api/v1/dex-swap/tokens | 获取代币列表


# **apiV1DexSwapBuildApprovePost**
> ApproveResponse apiV1DexSwapBuildApprovePost(buildApproveRequest)

构建授权交易

构建代币授权（Approve）的交易数据，默认授权最大额度（MaxUint256）。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = DEXSwapApi();
final buildApproveRequest = BuildApproveRequest(); // BuildApproveRequest | 

try {
    final result = api_instance.apiV1DexSwapBuildApprovePost(buildApproveRequest);
    print(result);
} catch (e) {
    print('Exception when calling DEXSwapApi->apiV1DexSwapBuildApprovePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **buildApproveRequest** | [**BuildApproveRequest**](BuildApproveRequest.md)|  | 

### Return type

[**ApproveResponse**](ApproveResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1DexSwapBuildTxPost**
> SwapResponse apiV1DexSwapBuildTxPost(buildTxRequest)

构建交易

构建代币兑换的 Swap 交易数据。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = DEXSwapApi();
final buildTxRequest = BuildTxRequest(); // BuildTxRequest | 

try {
    final result = api_instance.apiV1DexSwapBuildTxPost(buildTxRequest);
    print(result);
} catch (e) {
    print('Exception when calling DEXSwapApi->apiV1DexSwapBuildTxPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **buildTxRequest** | [**BuildTxRequest**](BuildTxRequest.md)|  | 

### Return type

[**SwapResponse**](SwapResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1DexSwapQuoteGet**
> QuoteResponse apiV1DexSwapQuoteGet(chain, fromToken, toToken, amount, slippage)

获取报价

获取代币兑换的最优报价。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = DEXSwapApi();
final chain = eth; // String | 链标识
final fromToken = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE; // String | 卖出代币合约地址
final toToken = 0xdAC17F958D2ee523a2206206994597C13D831ec7; // String | 买入代币合约地址
final amount = 10000000000000000000; // String | 卖出数量（最小单位）
final slippage = 0.5; // String | 滑点百分比

try {
    final result = api_instance.apiV1DexSwapQuoteGet(chain, fromToken, toToken, amount, slippage);
    print(result);
} catch (e) {
    print('Exception when calling DEXSwapApi->apiV1DexSwapQuoteGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chain** | **String**| 链标识 | 
 **fromToken** | **String**| 卖出代币合约地址 | 
 **toToken** | **String**| 买入代币合约地址 | 
 **amount** | **String**| 卖出数量（最小单位） | 
 **slippage** | **String**| 滑点百分比 | [optional] [default to '0.5']

### Return type

[**QuoteResponse**](QuoteResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1DexSwapTokensGet**
> TokenListResponse apiV1DexSwapTokensGet(chain)

获取代币列表

获取指定链上支持的代币列表。结果会缓存（默认60s）。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = DEXSwapApi();
final chain = eth; // String | 链标识

try {
    final result = api_instance.apiV1DexSwapTokensGet(chain);
    print(result);
} catch (e) {
    print('Exception when calling DEXSwapApi->apiV1DexSwapTokensGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chain** | **String**| 链标识 | 

### Return type

[**TokenListResponse**](TokenListResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

