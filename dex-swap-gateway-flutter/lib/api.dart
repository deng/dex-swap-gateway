//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/dex_swap_api.dart';
part 'api/jupiter_api.dart';
part 'api/system_api.dart';

part 'model/approve_response.dart';
part 'model/approve_transaction_data.dart';
part 'model/build_approve_request.dart';
part 'model/build_tx_request.dart';
part 'model/dex_protocol.dart';
part 'model/dex_router.dart';
part 'model/gateway_error_response.dart';
part 'model/health_response.dart';
part 'model/jupiter_execute_request.dart';
part 'model/jupiter_execute_response.dart';
part 'model/jupiter_order_response.dart';
part 'model/jupiter_order_response_route_plan_inner.dart';
part 'model/jupiter_swap_info.dart';
part 'model/okx_response.dart';
part 'model/quote_data.dart';
part 'model/quote_response.dart';
part 'model/router_result.dart';
part 'model/swap_response.dart';
part 'model/swap_result_item.dart';
part 'model/token_data.dart';
part 'model/token_info.dart';
part 'model/token_list_response.dart';
part 'model/transaction_data.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
