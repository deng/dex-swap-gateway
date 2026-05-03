//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class JupiterOrderResponse {
  /// Returns a new [JupiterOrderResponse] instance.
  JupiterOrderResponse({
    this.inputMint,
    this.inAmount,
    this.outputMint,
    this.outAmount,
    this.otherAmountThreshold,
    this.priceImpactPct,
    this.slippageBps,
    this.routePlan = const [],
    this.requestId,
    this.transaction,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? inputMint;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? inAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? outputMint;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? outAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? otherAmountThreshold;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? priceImpactPct;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? slippageBps;

  List<JupiterOrderResponseRoutePlanInner> routePlan;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? requestId;

  /// Base64 编码的未签名 Solana 交易
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? transaction;

  @override
  bool operator ==(Object other) => identical(this, other) || other is JupiterOrderResponse &&
    other.inputMint == inputMint &&
    other.inAmount == inAmount &&
    other.outputMint == outputMint &&
    other.outAmount == outAmount &&
    other.otherAmountThreshold == otherAmountThreshold &&
    other.priceImpactPct == priceImpactPct &&
    other.slippageBps == slippageBps &&
    _deepEquality.equals(other.routePlan, routePlan) &&
    other.requestId == requestId &&
    other.transaction == transaction;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (inputMint == null ? 0 : inputMint!.hashCode) +
    (inAmount == null ? 0 : inAmount!.hashCode) +
    (outputMint == null ? 0 : outputMint!.hashCode) +
    (outAmount == null ? 0 : outAmount!.hashCode) +
    (otherAmountThreshold == null ? 0 : otherAmountThreshold!.hashCode) +
    (priceImpactPct == null ? 0 : priceImpactPct!.hashCode) +
    (slippageBps == null ? 0 : slippageBps!.hashCode) +
    (routePlan.hashCode) +
    (requestId == null ? 0 : requestId!.hashCode) +
    (transaction == null ? 0 : transaction!.hashCode);

  @override
  String toString() => 'JupiterOrderResponse[inputMint=$inputMint, inAmount=$inAmount, outputMint=$outputMint, outAmount=$outAmount, otherAmountThreshold=$otherAmountThreshold, priceImpactPct=$priceImpactPct, slippageBps=$slippageBps, routePlan=$routePlan, requestId=$requestId, transaction=$transaction]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.inputMint != null) {
      json[r'inputMint'] = this.inputMint;
    } else {
      json[r'inputMint'] = null;
    }
    if (this.inAmount != null) {
      json[r'inAmount'] = this.inAmount;
    } else {
      json[r'inAmount'] = null;
    }
    if (this.outputMint != null) {
      json[r'outputMint'] = this.outputMint;
    } else {
      json[r'outputMint'] = null;
    }
    if (this.outAmount != null) {
      json[r'outAmount'] = this.outAmount;
    } else {
      json[r'outAmount'] = null;
    }
    if (this.otherAmountThreshold != null) {
      json[r'otherAmountThreshold'] = this.otherAmountThreshold;
    } else {
      json[r'otherAmountThreshold'] = null;
    }
    if (this.priceImpactPct != null) {
      json[r'priceImpactPct'] = this.priceImpactPct;
    } else {
      json[r'priceImpactPct'] = null;
    }
    if (this.slippageBps != null) {
      json[r'slippageBps'] = this.slippageBps;
    } else {
      json[r'slippageBps'] = null;
    }
      json[r'routePlan'] = this.routePlan;
    if (this.requestId != null) {
      json[r'requestId'] = this.requestId;
    } else {
      json[r'requestId'] = null;
    }
    if (this.transaction != null) {
      json[r'transaction'] = this.transaction;
    } else {
      json[r'transaction'] = null;
    }
    return json;
  }

  /// Returns a new [JupiterOrderResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static JupiterOrderResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "JupiterOrderResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "JupiterOrderResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return JupiterOrderResponse(
        inputMint: mapValueOfType<String>(json, r'inputMint'),
        inAmount: mapValueOfType<String>(json, r'inAmount'),
        outputMint: mapValueOfType<String>(json, r'outputMint'),
        outAmount: mapValueOfType<String>(json, r'outAmount'),
        otherAmountThreshold: mapValueOfType<String>(json, r'otherAmountThreshold'),
        priceImpactPct: mapValueOfType<String>(json, r'priceImpactPct'),
        slippageBps: mapValueOfType<int>(json, r'slippageBps'),
        routePlan: JupiterOrderResponseRoutePlanInner.listFromJson(json[r'routePlan']),
        requestId: mapValueOfType<String>(json, r'requestId'),
        transaction: mapValueOfType<String>(json, r'transaction'),
      );
    }
    return null;
  }

  static List<JupiterOrderResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <JupiterOrderResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = JupiterOrderResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, JupiterOrderResponse> mapFromJson(dynamic json) {
    final map = <String, JupiterOrderResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = JupiterOrderResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of JupiterOrderResponse-objects as value to a dart map
  static Map<String, List<JupiterOrderResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<JupiterOrderResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = JupiterOrderResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

