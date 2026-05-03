//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BuildApproveRequest {
  /// Returns a new [BuildApproveRequest] instance.
  BuildApproveRequest({
    required this.chain,
    required this.token,
    this.amount,
  });

  /// 链标识
  BuildApproveRequestChainEnum chain;

  /// 代币合约地址
  String token;

  /// 授权数量（最小单位，默认 MaxUint256）
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? amount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BuildApproveRequest &&
    other.chain == chain &&
    other.token == token &&
    other.amount == amount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chain.hashCode) +
    (token.hashCode) +
    (amount == null ? 0 : amount!.hashCode);

  @override
  String toString() => 'BuildApproveRequest[chain=$chain, token=$token, amount=$amount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'chain'] = this.chain;
      json[r'token'] = this.token;
    if (this.amount != null) {
      json[r'amount'] = this.amount;
    } else {
      json[r'amount'] = null;
    }
    return json;
  }

  /// Returns a new [BuildApproveRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BuildApproveRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BuildApproveRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BuildApproveRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BuildApproveRequest(
        chain: BuildApproveRequestChainEnum.fromJson(json[r'chain'])!,
        token: mapValueOfType<String>(json, r'token')!,
        amount: mapValueOfType<String>(json, r'amount'),
      );
    }
    return null;
  }

  static List<BuildApproveRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BuildApproveRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BuildApproveRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BuildApproveRequest> mapFromJson(dynamic json) {
    final map = <String, BuildApproveRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BuildApproveRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BuildApproveRequest-objects as value to a dart map
  static Map<String, List<BuildApproveRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BuildApproveRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BuildApproveRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chain',
    'token',
  };
}

/// 链标识
class BuildApproveRequestChainEnum {
  /// Instantiate a new enum with the provided [value].
  const BuildApproveRequestChainEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const eth = BuildApproveRequestChainEnum._(r'eth');
  static const bsc = BuildApproveRequestChainEnum._(r'bsc');
  static const polygon = BuildApproveRequestChainEnum._(r'polygon');
  static const base_ = BuildApproveRequestChainEnum._(r'base');
  static const arbitrum = BuildApproveRequestChainEnum._(r'arbitrum');
  static const optimism = BuildApproveRequestChainEnum._(r'optimism');
  static const sui = BuildApproveRequestChainEnum._(r'sui');
  static const ton = BuildApproveRequestChainEnum._(r'ton');
  static const trx = BuildApproveRequestChainEnum._(r'trx');

  /// List of all possible values in this [enum][BuildApproveRequestChainEnum].
  static const values = <BuildApproveRequestChainEnum>[
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

  static BuildApproveRequestChainEnum? fromJson(dynamic value) => BuildApproveRequestChainEnumTypeTransformer().decode(value);

  static List<BuildApproveRequestChainEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BuildApproveRequestChainEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BuildApproveRequestChainEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BuildApproveRequestChainEnum] to String,
/// and [decode] dynamic data back to [BuildApproveRequestChainEnum].
class BuildApproveRequestChainEnumTypeTransformer {
  factory BuildApproveRequestChainEnumTypeTransformer() => _instance ??= const BuildApproveRequestChainEnumTypeTransformer._();

  const BuildApproveRequestChainEnumTypeTransformer._();

  String encode(BuildApproveRequestChainEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a BuildApproveRequestChainEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BuildApproveRequestChainEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'eth': return BuildApproveRequestChainEnum.eth;
        case r'bsc': return BuildApproveRequestChainEnum.bsc;
        case r'polygon': return BuildApproveRequestChainEnum.polygon;
        case r'base': return BuildApproveRequestChainEnum.base_;
        case r'arbitrum': return BuildApproveRequestChainEnum.arbitrum;
        case r'optimism': return BuildApproveRequestChainEnum.optimism;
        case r'sui': return BuildApproveRequestChainEnum.sui;
        case r'ton': return BuildApproveRequestChainEnum.ton;
        case r'trx': return BuildApproveRequestChainEnum.trx;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [BuildApproveRequestChainEnumTypeTransformer] instance.
  static BuildApproveRequestChainEnumTypeTransformer? _instance;
}


