//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DEXSwapApi {
  DEXSwapApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// 构建授权交易
  ///
  /// 构建代币授权（Approve）的交易数据，默认授权最大额度（MaxUint256）。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BuildApproveRequest] buildApproveRequest (required):
  Future<Response> apiV1DexSwapBuildApprovePostWithHttpInfo(BuildApproveRequest buildApproveRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/dex-swap/build-approve';

    // ignore: prefer_final_locals
    Object? postBody = buildApproveRequest;

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

  /// 构建授权交易
  ///
  /// 构建代币授权（Approve）的交易数据，默认授权最大额度（MaxUint256）。
  ///
  /// Parameters:
  ///
  /// * [BuildApproveRequest] buildApproveRequest (required):
  Future<ApproveResponse?> apiV1DexSwapBuildApprovePost(BuildApproveRequest buildApproveRequest,) async {
    final response = await apiV1DexSwapBuildApprovePostWithHttpInfo(buildApproveRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApproveResponse',) as ApproveResponse;
    
    }
    return null;
  }

  /// 构建交易
  ///
  /// 构建代币兑换的 Swap 交易数据。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BuildTxRequest] buildTxRequest (required):
  Future<Response> apiV1DexSwapBuildTxPostWithHttpInfo(BuildTxRequest buildTxRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/dex-swap/build-tx';

    // ignore: prefer_final_locals
    Object? postBody = buildTxRequest;

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

  /// 构建交易
  ///
  /// 构建代币兑换的 Swap 交易数据。
  ///
  /// Parameters:
  ///
  /// * [BuildTxRequest] buildTxRequest (required):
  Future<SwapResponse?> apiV1DexSwapBuildTxPost(BuildTxRequest buildTxRequest,) async {
    final response = await apiV1DexSwapBuildTxPostWithHttpInfo(buildTxRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SwapResponse',) as SwapResponse;
    
    }
    return null;
  }

  /// 获取报价
  ///
  /// 获取代币兑换的最优报价。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] chain (required):
  ///   链标识
  ///
  /// * [String] fromToken (required):
  ///   卖出代币合约地址
  ///
  /// * [String] toToken (required):
  ///   买入代币合约地址
  ///
  /// * [String] amount (required):
  ///   卖出数量（最小单位）
  ///
  /// * [String] slippage:
  ///   滑点百分比
  Future<Response> apiV1DexSwapQuoteGetWithHttpInfo(String chain, String fromToken, String toToken, String amount, { String? slippage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/dex-swap/quote';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'chain', chain));
      queryParams.addAll(_queryParams('', 'fromToken', fromToken));
      queryParams.addAll(_queryParams('', 'toToken', toToken));
      queryParams.addAll(_queryParams('', 'amount', amount));
    if (slippage != null) {
      queryParams.addAll(_queryParams('', 'slippage', slippage));
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

  /// 获取报价
  ///
  /// 获取代币兑换的最优报价。
  ///
  /// Parameters:
  ///
  /// * [String] chain (required):
  ///   链标识
  ///
  /// * [String] fromToken (required):
  ///   卖出代币合约地址
  ///
  /// * [String] toToken (required):
  ///   买入代币合约地址
  ///
  /// * [String] amount (required):
  ///   卖出数量（最小单位）
  ///
  /// * [String] slippage:
  ///   滑点百分比
  Future<QuoteResponse?> apiV1DexSwapQuoteGet(String chain, String fromToken, String toToken, String amount, { String? slippage, }) async {
    final response = await apiV1DexSwapQuoteGetWithHttpInfo(chain, fromToken, toToken, amount,  slippage: slippage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'QuoteResponse',) as QuoteResponse;
    
    }
    return null;
  }

  /// 获取代币列表
  ///
  /// 获取指定链上支持的代币列表。结果会缓存（默认60s）。
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] chain (required):
  ///   链标识
  Future<Response> apiV1DexSwapTokensGetWithHttpInfo(String chain,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/dex-swap/tokens';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'chain', chain));

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

  /// 获取代币列表
  ///
  /// 获取指定链上支持的代币列表。结果会缓存（默认60s）。
  ///
  /// Parameters:
  ///
  /// * [String] chain (required):
  ///   链标识
  Future<TokenListResponse?> apiV1DexSwapTokensGet(String chain,) async {
    final response = await apiV1DexSwapTokensGetWithHttpInfo(chain,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TokenListResponse',) as TokenListResponse;
    
    }
    return null;
  }
}
