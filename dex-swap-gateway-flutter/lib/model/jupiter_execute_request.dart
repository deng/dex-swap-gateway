//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class JupiterExecuteRequest {
  /// Returns a new [JupiterExecuteRequest] instance.
  JupiterExecuteRequest({
    required this.signedTransaction,
    required this.requestId,
  });

  /// 客户端签名后的 Base64 编码 Solana 交易
  String signedTransaction;

  /// 从 /jupiter/order 返回的 requestId
  String requestId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is JupiterExecuteRequest &&
    other.signedTransaction == signedTransaction &&
    other.requestId == requestId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signedTransaction.hashCode) +
    (requestId.hashCode);

  @override
  String toString() => 'JupiterExecuteRequest[signedTransaction=$signedTransaction, requestId=$requestId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'signedTransaction'] = this.signedTransaction;
      json[r'requestId'] = this.requestId;
    return json;
  }

  /// Returns a new [JupiterExecuteRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static JupiterExecuteRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "JupiterExecuteRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "JupiterExecuteRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return JupiterExecuteRequest(
        signedTransaction: mapValueOfType<String>(json, r'signedTransaction')!,
        requestId: mapValueOfType<String>(json, r'requestId')!,
      );
    }
    return null;
  }

  static List<JupiterExecuteRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <JupiterExecuteRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = JupiterExecuteRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, JupiterExecuteRequest> mapFromJson(dynamic json) {
    final map = <String, JupiterExecuteRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = JupiterExecuteRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of JupiterExecuteRequest-objects as value to a dart map
  static Map<String, List<JupiterExecuteRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<JupiterExecuteRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = JupiterExecuteRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'signedTransaction',
    'requestId',
  };
}

