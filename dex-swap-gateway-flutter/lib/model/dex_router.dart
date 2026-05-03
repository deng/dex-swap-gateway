//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DexRouter {
  /// Returns a new [DexRouter] instance.
  DexRouter({
    this.dexProtocol,
    this.fromToken,
    this.fromTokenIndex,
    this.toToken,
    this.toTokenIndex,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DexProtocol? dexProtocol;

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
  String? fromTokenIndex;

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
  String? toTokenIndex;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DexRouter &&
    other.dexProtocol == dexProtocol &&
    other.fromToken == fromToken &&
    other.fromTokenIndex == fromTokenIndex &&
    other.toToken == toToken &&
    other.toTokenIndex == toTokenIndex;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dexProtocol == null ? 0 : dexProtocol!.hashCode) +
    (fromToken == null ? 0 : fromToken!.hashCode) +
    (fromTokenIndex == null ? 0 : fromTokenIndex!.hashCode) +
    (toToken == null ? 0 : toToken!.hashCode) +
    (toTokenIndex == null ? 0 : toTokenIndex!.hashCode);

  @override
  String toString() => 'DexRouter[dexProtocol=$dexProtocol, fromToken=$fromToken, fromTokenIndex=$fromTokenIndex, toToken=$toToken, toTokenIndex=$toTokenIndex]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.dexProtocol != null) {
      json[r'dexProtocol'] = this.dexProtocol;
    } else {
      json[r'dexProtocol'] = null;
    }
    if (this.fromToken != null) {
      json[r'fromToken'] = this.fromToken;
    } else {
      json[r'fromToken'] = null;
    }
    if (this.fromTokenIndex != null) {
      json[r'fromTokenIndex'] = this.fromTokenIndex;
    } else {
      json[r'fromTokenIndex'] = null;
    }
    if (this.toToken != null) {
      json[r'toToken'] = this.toToken;
    } else {
      json[r'toToken'] = null;
    }
    if (this.toTokenIndex != null) {
      json[r'toTokenIndex'] = this.toTokenIndex;
    } else {
      json[r'toTokenIndex'] = null;
    }
    return json;
  }

  /// Returns a new [DexRouter] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DexRouter? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DexRouter[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DexRouter[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DexRouter(
        dexProtocol: DexProtocol.fromJson(json[r'dexProtocol']),
        fromToken: TokenInfo.fromJson(json[r'fromToken']),
        fromTokenIndex: mapValueOfType<String>(json, r'fromTokenIndex'),
        toToken: TokenInfo.fromJson(json[r'toToken']),
        toTokenIndex: mapValueOfType<String>(json, r'toTokenIndex'),
      );
    }
    return null;
  }

  static List<DexRouter> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DexRouter>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DexRouter.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DexRouter> mapFromJson(dynamic json) {
    final map = <String, DexRouter>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DexRouter.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DexRouter-objects as value to a dart map
  static Map<String, List<DexRouter>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DexRouter>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DexRouter.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

