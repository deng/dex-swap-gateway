//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuoteData {
  /// Returns a new [QuoteData] instance.
  QuoteData({
    this.chainIndex,
    this.routerResult,
    this.dexRouterList = const [],
    this.estimatedGas,
    this.fromToken,
    this.toToken,
    this.fromTokenAmount,
    this.toTokenAmount,
    this.price,
    this.priceImpactPercentage,
    this.quoteDeadline,
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RouterResult? routerResult;

  List<DexRouter> dexRouterList;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? estimatedGas;

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
  String? price;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? priceImpactPercentage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? quoteDeadline;

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
  bool operator ==(Object other) => identical(this, other) || other is QuoteData &&
    other.chainIndex == chainIndex &&
    other.routerResult == routerResult &&
    _deepEquality.equals(other.dexRouterList, dexRouterList) &&
    other.estimatedGas == estimatedGas &&
    other.fromToken == fromToken &&
    other.toToken == toToken &&
    other.fromTokenAmount == fromTokenAmount &&
    other.toTokenAmount == toTokenAmount &&
    other.price == price &&
    other.priceImpactPercentage == priceImpactPercentage &&
    other.quoteDeadline == quoteDeadline &&
    other.router == router &&
    other.swapMode == swapMode &&
    other.tradeFee == tradeFee;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chainIndex == null ? 0 : chainIndex!.hashCode) +
    (routerResult == null ? 0 : routerResult!.hashCode) +
    (dexRouterList.hashCode) +
    (estimatedGas == null ? 0 : estimatedGas!.hashCode) +
    (fromToken == null ? 0 : fromToken!.hashCode) +
    (toToken == null ? 0 : toToken!.hashCode) +
    (fromTokenAmount == null ? 0 : fromTokenAmount!.hashCode) +
    (toTokenAmount == null ? 0 : toTokenAmount!.hashCode) +
    (price == null ? 0 : price!.hashCode) +
    (priceImpactPercentage == null ? 0 : priceImpactPercentage!.hashCode) +
    (quoteDeadline == null ? 0 : quoteDeadline!.hashCode) +
    (router == null ? 0 : router!.hashCode) +
    (swapMode == null ? 0 : swapMode!.hashCode) +
    (tradeFee == null ? 0 : tradeFee!.hashCode);

  @override
  String toString() => 'QuoteData[chainIndex=$chainIndex, routerResult=$routerResult, dexRouterList=$dexRouterList, estimatedGas=$estimatedGas, fromToken=$fromToken, toToken=$toToken, fromTokenAmount=$fromTokenAmount, toTokenAmount=$toTokenAmount, price=$price, priceImpactPercentage=$priceImpactPercentage, quoteDeadline=$quoteDeadline, router=$router, swapMode=$swapMode, tradeFee=$tradeFee]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.chainIndex != null) {
      json[r'chainIndex'] = this.chainIndex;
    } else {
      json[r'chainIndex'] = null;
    }
    if (this.routerResult != null) {
      json[r'routerResult'] = this.routerResult;
    } else {
      json[r'routerResult'] = null;
    }
      json[r'dexRouterList'] = this.dexRouterList;
    if (this.estimatedGas != null) {
      json[r'estimatedGas'] = this.estimatedGas;
    } else {
      json[r'estimatedGas'] = null;
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
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
    if (this.priceImpactPercentage != null) {
      json[r'priceImpactPercentage'] = this.priceImpactPercentage;
    } else {
      json[r'priceImpactPercentage'] = null;
    }
    if (this.quoteDeadline != null) {
      json[r'quoteDeadline'] = this.quoteDeadline;
    } else {
      json[r'quoteDeadline'] = null;
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

  /// Returns a new [QuoteData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuoteData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "QuoteData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "QuoteData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return QuoteData(
        chainIndex: mapValueOfType<String>(json, r'chainIndex'),
        routerResult: RouterResult.fromJson(json[r'routerResult']),
        dexRouterList: DexRouter.listFromJson(json[r'dexRouterList']),
        estimatedGas: mapValueOfType<String>(json, r'estimatedGas'),
        fromToken: TokenInfo.fromJson(json[r'fromToken']),
        toToken: TokenInfo.fromJson(json[r'toToken']),
        fromTokenAmount: mapValueOfType<String>(json, r'fromTokenAmount'),
        toTokenAmount: mapValueOfType<String>(json, r'toTokenAmount'),
        price: mapValueOfType<String>(json, r'price'),
        priceImpactPercentage: mapValueOfType<String>(json, r'priceImpactPercentage'),
        quoteDeadline: mapValueOfType<String>(json, r'quoteDeadline'),
        router: mapValueOfType<String>(json, r'router'),
        swapMode: mapValueOfType<String>(json, r'swapMode'),
        tradeFee: mapValueOfType<String>(json, r'tradeFee'),
      );
    }
    return null;
  }

  static List<QuoteData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuoteData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuoteData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuoteData> mapFromJson(dynamic json) {
    final map = <String, QuoteData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuoteData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuoteData-objects as value to a dart map
  static Map<String, List<QuoteData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuoteData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuoteData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

