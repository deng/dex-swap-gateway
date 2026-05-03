//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dex_swap_gateway/api.dart';
import 'package:test/test.dart';


/// tests for DEXSwapApi
void main() {
  // final instance = DEXSwapApi();

  group('tests for DEXSwapApi', () {
    // 构建授权交易
    //
    // 构建代币授权（Approve）的交易数据，默认授权最大额度（MaxUint256）。
    //
    //Future<ApproveResponse> apiV1DexSwapBuildApprovePost(BuildApproveRequest buildApproveRequest) async
    test('test apiV1DexSwapBuildApprovePost', () async {
      // TODO
    });

    // 构建交易
    //
    // 构建代币兑换的 Swap 交易数据。
    //
    //Future<SwapResponse> apiV1DexSwapBuildTxPost(BuildTxRequest buildTxRequest) async
    test('test apiV1DexSwapBuildTxPost', () async {
      // TODO
    });

    // 获取报价
    //
    // 获取代币兑换的最优报价。
    //
    //Future<QuoteResponse> apiV1DexSwapQuoteGet(String chain, String fromToken, String toToken, String amount, { String slippage }) async
    test('test apiV1DexSwapQuoteGet', () async {
      // TODO
    });

    // 获取代币列表
    //
    // 获取指定链上支持的代币列表。结果会缓存（默认60s）。
    //
    //Future<TokenListResponse> apiV1DexSwapTokensGet(String chain) async
    test('test apiV1DexSwapTokensGet', () async {
      // TODO
    });

  });
}
