//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RouterResult {
  /// Returns a new [RouterResult] instance.
  RouterResult({
    this.chainIndex,
    this.dexRouterList = const [],
    this.estimateGasFee,
    this.fromToken,
    this.toToken,
    this.fromTokenAmount,
    this.toTokenAmount,
    this.priceImpactPercent,
    this.router,
    this.swapMode,
    this.tradeFee,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? chainIndex;

  List<DexRouter> dexRouterList;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? estimateGasFee;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TokenInfo? fromToken;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TokenInfo? toToken;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? fromTokenAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? toTokenAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? priceImpactPercent;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? router;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? swapMode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tradeFee;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RouterResult &&
    other.chainIndex == chainIndex &&
    _deepEquality.equals(other.dexRouterList, dexRouterList) &&
    other.estimateGasFee == estimateGasFee &&
    other.fromToken == fromToken &&
    other.toToken == toToken &&
    other.fromTokenAmount == fromTokenAmount &&
    other.toTokenAmount == toTokenAmount &&
    other.priceImpactPercent == priceImpactPercent &&
    other.router == router &&
    other.swapMode == swapMode &&
    other.tradeFee == tradeFee;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chainIndex == null ? 0 : chainIndex!.hashCode) +
    (dexRouterList.hashCode) +
    (estimateGasFee == null ? 0 : estimateGasFee!.hashCode) +
    (fromToken == null ? 0 : fromToken!.hashCode) +
    (toToken == null ? 0 : toToken!.hashCode) +
    (fromTokenAmount == null ? 0 : fromTokenAmount!.hashCode) +
    (toTokenAmount == null ? 0 : toTokenAmount!.hashCode) +
    (priceImpactPercent == null ? 0 : priceImpactPercent!.hashCode) +
    (router == null ? 0 : router!.hashCode) +
    (swapMode == null ? 0 : swapMode!.hashCode) +
    (tradeFee == null ? 0 : tradeFee!.hashCode);

  @override
  String toString() => 'RouterResult[chainIndex=$chainIndex, dexRouterList=$dexRouterList, estimateGasFee=$estimateGasFee, fromToken=$fromToken, toToken=$toToken, fromTokenAmount=$fromTokenAmount, toTokenAmount=$toTokenAmount, priceImpactPercent=$priceImpactPercent, router=$router, swapMode=$swapMode, tradeFee=$tradeFee]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.chainIndex != null) {
      json[r'chainIndex'] = this.chainIndex;
    } else {
      json[r'chainIndex'] = null;
    }
      json[r'dexRouterList'] = this.dexRouterList;
    if (this.estimateGasFee != null) {
      json[r'estimateGasFee'] = this.estimateGasFee;
    } else {
      json[r'estimateGasFee'] = null;
    }
    if (this.fromToken != null) {
      json[r'fromToken'] = this.fromToken;
    } else {
      json[r'fromToken'] = null;
    }
    if (this.toToken != null) {
      json[r'toToken'] = this.toToken;
    } else {
      json[r'toToken'] = null;
    }
    if (this.fromTokenAmount != null) {
      json[r'fromTokenAmount'] = this.fromTokenAmount;
    } else {
      json[r'fromTokenAmount'] = null;
    }
    if (this.toTokenAmount != null) {
      json[r'toTokenAmount'] = this.toTokenAmount;
    } else {
      json[r'toTokenAmount'] = null;
    }
    if (this.priceImpactPercent != null) {
      json[r'priceImpactPercent'] = this.priceImpactPercent;
    } else {
      json[r'priceImpactPercent'] = null;
    }
    if (this.router != null) {
      json[r'router'] = this.router;
    } else {
      json[r'router'] = null;
    }
    if (this.swapMode != null) {
      json[r'swapMode'] = this.swapMode;
    } else {
      json[r'swapMode'] = null;
    }
    if (this.tradeFee != null) {
      json[r'tradeFee'] = this.tradeFee;
    } else {
      json[r'tradeFee'] = null;
    }
    return json;
  }

  /// Returns a new [RouterResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RouterResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RouterResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RouterResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RouterResult(
        chainIndex: mapValueOfType<String>(json, r'chainIndex'),
        dexRouterList: DexRouter.listFromJson(json[r'dexRouterList']),
        estimateGasFee: mapValueOfType<String>(json, r'estimateGasFee'),
        fromToken: TokenInfo.fromJson(json[r'fromToken']),
        toToken: TokenInfo.fromJson(json[r'toToken']),
        fromTokenAmount: mapValueOfType<String>(json, r'fromTokenAmount'),
        toTokenAmount: mapValueOfType<String>(json, r'toTokenAmount'),
        priceImpactPercent: mapValueOfType<String>(json, r'priceImpactPercent'),
        router: mapValueOfType<String>(json, r'router'),
        swapMode: mapValueOfType<String>(json, r'swapMode'),
        tradeFee: mapValueOfType<String>(json, r'tradeFee'),
      );
    }
    return null;
  }

  static List<RouterResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RouterResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RouterResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RouterResult> mapFromJson(dynamic json) {
    final map = <String, RouterResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RouterResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RouterResult-objects as value to a dart map
  static Map<String, List<RouterResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RouterResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RouterResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

