//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class JupiterApi {
  JupiterApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// 执行 Jupiter Swap 交易
  ///
  /// 提交已签名的 Solana 交易到 Jupiter 执行。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [JupiterExecuteRequest] jupiterExecuteRequest (required):
  Future<Response> apiV1JupiterExecutePostWithHttpInfo(JupiterExecuteRequest jupiterExecuteRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/jupiter/execute';

    // ignore: prefer_final_locals
    Object? postBody = jupiterExecuteRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// 执行 Jupiter Swap 交易
  ///
  /// 提交已签名的 Solana 交易到 Jupiter 执行。
  ///
  /// Parameters:
  ///
  /// * [JupiterExecuteRequest] jupiterExecuteRequest (required):
  Future<JupiterExecuteResponse?> apiV1JupiterExecutePost(JupiterExecuteRequest jupiterExecuteRequest,) async {
    final response = await apiV1JupiterExecutePostWithHttpInfo(jupiterExecuteRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'JupiterExecuteResponse',) as JupiterExecuteResponse;
    
    }
    return null;
  }

  /// 获取 Jupiter 报价和交易
  ///
  /// 通过 Jupiter Swap API v2 获取 Solana 链上代币兑换的报价和未签名交易。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] inputMint (required):
  ///   输入代币的 Mint 地址
  ///
  /// * [String] outputMint (required):
  ///   输出代币的 Mint 地址
  ///
  /// * [String] amount (required):
  ///   输入数量（最小单位）
  ///
  /// * [String] taker (required):
  ///   用户钱包公钥
  ///
  /// * [String] slippageBps:
  ///   滑点（基点，如 50 = 0.5%）
  ///
  /// * [String] swapMode:
  ///   交易模式
  ///
  /// * [bool] dynamicSlippage:
  ///   是否启用动态滑点
  Future<Response> apiV1JupiterOrderGetWithHttpInfo(String inputMint, String outputMint, String amount, String taker, { String? slippageBps, String? swapMode, bool? dynamicSlippage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/jupiter/order';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'inputMint', inputMint));
      queryParams.addAll(_queryParams('', 'outputMint', outputMint));
      queryParams.addAll(_queryParams('', 'amount', amount));
      queryParams.addAll(_queryParams('', 'taker', taker));
    if (slippageBps != null) {
      queryParams.addAll(_queryParams('', 'slippageBps', slippageBps));
    }
    if (swapMode != null) {
      queryParams.addAll(_queryParams('', 'swapMode', swapMode));
    }
    if (dynamicSlippage != null) {
      queryParams.addAll(_queryParams('', 'dynamicSlippage', dynamicSlippage));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// 获取 Jupiter 报价和交易
  ///
  /// 通过 Jupiter Swap API v2 获取 Solana 链上代币兑换的报价和未签名交易。
  ///
  /// Parameters:
  ///
  /// * [String] inputMint (required):
  ///   输入代币的 Mint 地址
  ///
  /// * [String] outputMint (required):
  ///   输出代币的 Mint 地址
  ///
  /// * [String] amount (required):
  ///   输入数量（最小单位）
  ///
  /// * [String] taker (required):
  ///   用户钱包公钥
  ///
  /// * [String] slippageBps:
  ///   滑点（基点，如 50 = 0.5%）
  ///
  /// * [String] swapMode:
  ///   交易模式
  ///
  /// * [bool] dynamicSlippage:
  ///   是否启用动态滑点
  Future<JupiterOrderResponse?> apiV1JupiterOrderGet(String inputMint, String outputMint, String amount, String taker, { String? slippageBps, String? swapMode, bool? dynamicSlippage, }) async {
    final response = await apiV1JupiterOrderGetWithHttpInfo(inputMint, outputMint, amount, taker,  slippageBps: slippageBps, swapMode: swapMode, dynamicSlippage: dynamicSlippage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'JupiterOrderResponse',) as JupiterOrderResponse;
    
    }
    return null;
  }

  /// 获取 Jupiter 支持的所有代币列表
  ///
  /// 获取 Jupiter Swap 聚合器在 Solana 链上支持的所有代币。数据来源：Jupiter Token List API。
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> apiV1JupiterTokensGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/jupiter/tokens';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// 获取 Jupiter 支持的所有代币列表
  ///
  /// 获取 Jupiter Swap 聚合器在 Solana 链上支持的所有代币。数据来源：Jupiter Token List API。
  Future<List<JupiterTokenData>?> apiV1JupiterTokensGet() async {
    final response = await apiV1JupiterTokensGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<JupiterTokenData>') as List)
        .cast<JupiterTokenData>()
        .toList(growable: false);

    }
    return null;
  }
}
