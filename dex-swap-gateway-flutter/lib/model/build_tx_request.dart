//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BuildTxRequest {
  /// Returns a new [BuildTxRequest] instance.
  BuildTxRequest({
    required this.chain,
    required this.fromToken,
    required this.toToken,
    required this.amount,
    required this.fromAddress,
    this.slippage = '0.5',
  });

  /// 链标识
  BuildTxRequestChainEnum chain;

  /// 卖出代币合约地址
  String fromToken;

  /// 买入代币合约地址
  String toToken;

  /// 卖出数量（最小单位）
  String amount;

  /// 用户钱包地址
  String fromAddress;

  /// 滑点百分比
  String slippage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BuildTxRequest &&
    other.chain == chain &&
    other.fromToken == fromToken &&
    other.toToken == toToken &&
    other.amount == amount &&
    other.fromAddress == fromAddress &&
    other.slippage == slippage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chain.hashCode) +
    (fromToken.hashCode) +
    (toToken.hashCode) +
    (amount.hashCode) +
    (fromAddress.hashCode) +
    (slippage.hashCode);

  @override
  String toString() => 'BuildTxRequest[chain=$chain, fromToken=$fromToken, toToken=$toToken, amount=$amount, fromAddress=$fromAddress, slippage=$slippage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'chain'] = this.chain;
      json[r'fromToken'] = this.fromToken;
      json[r'toToken'] = this.toToken;
      json[r'amount'] = this.amount;
      json[r'fromAddress'] = this.fromAddress;
      json[r'slippage'] = this.slippage;
    return json;
  }

  /// Returns a new [BuildTxRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BuildTxRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BuildTxRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BuildTxRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BuildTxRequest(
        chain: BuildTxRequestChainEnum.fromJson(json[r'chain'])!,
        fromToken: mapValueOfType<String>(json, r'fromToken')!,
        toToken: mapValueOfType<String>(json, r'toToken')!,
        amount: mapValueOfType<String>(json, r'amount')!,
        fromAddress: mapValueOfType<String>(json, r'fromAddress')!,
        slippage: mapValueOfType<String>(json, r'slippage') ?? '0.5',
      );
    }
    return null;
  }

  static List<BuildTxRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BuildTxRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BuildTxRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BuildTxRequest> mapFromJson(dynamic json) {
    final map = <String, BuildTxRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BuildTxRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BuildTxRequest-objects as value to a dart map
  static Map<String, List<BuildTxRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BuildTxRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BuildTxRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chain',
    'fromToken',
    'toToken',
    'amount',
    'fromAddress',
  };
}

/// 链标识
class BuildTxRequestChainEnum {
  /// Instantiate a new enum with the provided [value].
  const BuildTxRequestChainEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const eth = BuildTxRequestChainEnum._(r'eth');
  static const bsc = BuildTxRequestChainEnum._(r'bsc');
  static const polygon = BuildTxRequestChainEnum._(r'polygon');
  static const base_ = BuildTxRequestChainEnum._(r'base');
  static const arbitrum = BuildTxRequestChainEnum._(r'arbitrum');
  static const optimism = BuildTxRequestChainEnum._(r'optimism');
  static const sui = BuildTxRequestChainEnum._(r'sui');
  static const ton = BuildTxRequestChainEnum._(r'ton');
  static const trx = BuildTxRequestChainEnum._(r'trx');

  /// List of all possible values in this [enum][BuildTxRequestChainEnum].
  static const values = <BuildTxRequestChainEnum>[
    eth,
    bsc,
    polygon,
    base_,
    arbitrum,
    optimism,
    sui,
    ton,
    trx,
  ];

  static BuildTxRequestChainEnum? fromJson(dynamic value) => BuildTxRequestChainEnumTypeTransformer().decode(value);

  static List<BuildTxRequestChainEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BuildTxRequestChainEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BuildTxRequestChainEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BuildTxRequestChainEnum] to String,
/// and [decode] dynamic data back to [BuildTxRequestChainEnum].
class BuildTxRequestChainEnumTypeTransformer {
  factory BuildTxRequestChainEnumTypeTransformer() => _instance ??= const BuildTxRequestChainEnumTypeTransformer._();

  const BuildTxRequestChainEnumTypeTransformer._();

  String encode(BuildTxRequestChainEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a BuildTxRequestChainEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BuildTxRequestChainEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'eth': return BuildTxRequestChainEnum.eth;
        case r'bsc': return BuildTxRequestChainEnum.bsc;
        case r'polygon': return BuildTxRequestChainEnum.polygon;
        case r'base': return BuildTxRequestChainEnum.base_;
        case r'arbitrum': return BuildTxRequestChainEnum.arbitrum;
        case r'optimism': return BuildTxRequestChainEnum.optimism;
        case r'sui': return BuildTxRequestChainEnum.sui;
        case r'ton': return BuildTxRequestChainEnum.ton;
        case r'trx': return BuildTxRequestChainEnum.trx;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [BuildTxRequestChainEnumTypeTransformer] instance.
  static BuildTxRequestChainEnumTypeTransformer? _instance;
}


