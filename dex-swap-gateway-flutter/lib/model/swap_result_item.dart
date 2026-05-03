//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SwapResultItem {
  /// Returns a new [SwapResultItem] instance.
  SwapResultItem({
    this.routerResult,
    this.tx,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  RouterResult? routerResult;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TransactionData? tx;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SwapResultItem &&
    other.routerResult == routerResult &&
    other.tx == tx;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (routerResult == null ? 0 : routerResult!.hashCode) +
    (tx == null ? 0 : tx!.hashCode);

  @override
  String toString() => 'SwapResultItem[routerResult=$routerResult, tx=$tx]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.routerResult != null) {
      json[r'routerResult'] = this.routerResult;
    } else {
      json[r'routerResult'] = null;
    }
    if (this.tx != null) {
      json[r'tx'] = this.tx;
    } else {
      json[r'tx'] = null;
    }
    return json;
  }

  /// Returns a new [SwapResultItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SwapResultItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SwapResultItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SwapResultItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SwapResultItem(
        routerResult: RouterResult.fromJson(json[r'routerResult']),
        tx: TransactionData.fromJson(json[r'tx']),
      );
    }
    return null;
  }

  static List<SwapResultItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SwapResultItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SwapResultItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SwapResultItem> mapFromJson(dynamic json) {
    final map = <String, SwapResultItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SwapResultItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SwapResultItem-objects as value to a dart map
  static Map<String, List<SwapResultItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SwapResultItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SwapResultItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

