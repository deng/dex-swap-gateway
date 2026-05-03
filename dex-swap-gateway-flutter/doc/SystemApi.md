# dex_swap_gateway.api.SystemApi

## Load the API package
```dart
import 'package:dex_swap_gateway/api.dart';
```

All URIs are relative to *https://dex-swap.bithub.pro*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1HealthGet**](SystemApi.md#apiv1healthget) | **GET** /api/v1/health | 健康检查


# **apiV1HealthGet**
> HealthResponse apiV1HealthGet()

健康检查

### Example
```dart
import 'package:dex_swap_gateway/api.dart';

final api_instance = SystemApi();

try {
    final result = api_instance.apiV1HealthGet();
    print(result);
} catch (e) {
    print('Exception when calling SystemApi->apiV1HealthGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthResponse**](HealthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

