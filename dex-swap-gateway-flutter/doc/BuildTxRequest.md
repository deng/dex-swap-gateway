# dex_swap_gateway.model.BuildTxRequest

## Load the model package
```dart
import 'package:dex_swap_gateway/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**chain** | **String** | 链标识 | 
**fromToken** | **String** | 卖出代币合约地址 | 
**toToken** | **String** | 买入代币合约地址 | 
**amount** | **String** | 卖出数量（最小单位） | 
**fromAddress** | **String** | 用户钱包地址 | 
**slippage** | **String** | 滑点百分比 | [optional] [default to '0.5']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


