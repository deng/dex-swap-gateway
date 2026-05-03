# dex_swap_gateway.model.JupiterOrderResponse

## Load the model package
```dart
import 'package:dex_swap_gateway/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**inputMint** | **String** |  | [optional] 
**inAmount** | **String** |  | [optional] 
**outputMint** | **String** |  | [optional] 
**outAmount** | **String** |  | [optional] 
**otherAmountThreshold** | **String** |  | [optional] 
**priceImpactPct** | **String** |  | [optional] 
**slippageBps** | **int** |  | [optional] 
**routePlan** | [**List<JupiterOrderResponseRoutePlanInner>**](JupiterOrderResponseRoutePlanInner.md) |  | [optional] [default to const []]
**requestId** | **String** |  | [optional] 
**transaction** | **String** | Base64 编码的未签名 Solana 交易 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


