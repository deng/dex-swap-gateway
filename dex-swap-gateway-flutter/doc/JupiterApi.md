# dex_swap_gateway.api.JupiterApi

## Load the API package
```dart
import 'package:dex_swap_gateway/api.dart';
```

All URIs are relative to *https://dex-swap.bithub.pro*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1JupiterExecutePost**](JupiterApi.md#apiv1jupiterexecutepost) | **POST** /api/v1/jupiter/execute | 执行 Jupiter Swap 交易
[**apiV1JupiterOrderGet**](JupiterApi.md#apiv1jupiterorderget) | **GET** /api/v1/jupiter/order | 获取 Jupiter 报价和交易
[**apiV1JupiterTokensGet**](JupiterApi.md#apiv1jupitertokensget) | **GET** /api/v1/jupiter/tokens | 获取 Jupiter 支持的所有代币列表


# **apiV1JupiterExecutePost**
> JupiterExecuteResponse apiV1JupiterExecutePost(jupiterExecuteRequest)

执行 Jupiter Swap 交易

提交已签名的 Solana 交易到 Jupiter 执行。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = JupiterApi();
final jupiterExecuteRequest = JupiterExecuteRequest(); // JupiterExecuteRequest | 

try {
    final result = api_instance.apiV1JupiterExecutePost(jupiterExecuteRequest);
    print(result);
} catch (e) {
    print('Exception when calling JupiterApi->apiV1JupiterExecutePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jupiterExecuteRequest** | [**JupiterExecuteRequest**](JupiterExecuteRequest.md)|  | 

### Return type

[**JupiterExecuteResponse**](JupiterExecuteResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1JupiterOrderGet**
> JupiterOrderResponse apiV1JupiterOrderGet(inputMint, outputMint, amount, taker, slippageBps, swapMode, dynamicSlippage)

获取 Jupiter 报价和交易

通过 Jupiter Swap API v2 获取 Solana 链上代币兑换的报价和未签名交易。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = JupiterApi();
final inputMint = So11111111111111111111111111111111111111112; // String | 输入代币的 Mint 地址
final outputMint = EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v; // String | 输出代币的 Mint 地址
final amount = 100000000; // String | 输入数量（最小单位）
final taker = Gg7YdKqP7P8KqV3Q5ZxJ9X8L7s5T2p1Bv3c4D5e6F7g8h9j0k1l2m3n4o5p6; // String | 用户钱包公钥
final slippageBps = 50; // String | 滑点（基点，如 50 = 0.5%）
final swapMode = ExactIn; // String | 交易模式
final dynamicSlippage = true; // bool | 是否启用动态滑点

try {
    final result = api_instance.apiV1JupiterOrderGet(inputMint, outputMint, amount, taker, slippageBps, swapMode, dynamicSlippage);
    print(result);
} catch (e) {
    print('Exception when calling JupiterApi->apiV1JupiterOrderGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **inputMint** | **String**| 输入代币的 Mint 地址 | 
 **outputMint** | **String**| 输出代币的 Mint 地址 | 
 **amount** | **String**| 输入数量（最小单位） | 
 **taker** | **String**| 用户钱包公钥 | 
 **slippageBps** | **String**| 滑点（基点，如 50 = 0.5%） | [optional] 
 **swapMode** | **String**| 交易模式 | [optional] [default to 'ExactIn']
 **dynamicSlippage** | **bool**| 是否启用动态滑点 | [optional] 

### Return type

[**JupiterOrderResponse**](JupiterOrderResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1JupiterTokensGet**
> List<JupiterTokenData> apiV1JupiterTokensGet()

获取 Jupiter 支持的所有代币列表

获取 Jupiter Swap 聚合器在 Solana 链上支持的所有代币。数据来源：Jupiter Token List API。

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = JupiterApi();

try {
    final result = api_instance.apiV1JupiterTokensGet();
    print(result);
} catch (e) {
    print('Exception when calling JupiterApi->apiV1JupiterTokensGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<JupiterTokenData>**](JupiterTokenData.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

