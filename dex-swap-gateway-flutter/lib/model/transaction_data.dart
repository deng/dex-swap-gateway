//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TransactionData {
  /// Returns a new [TransactionData] instance.
  TransactionData({
    this.data,
    this.from,
    this.to,
    this.value,
    this.gas,
    this.gasPrice,
    this.maxPriorityFeePerGas,
    this.maxSpendAmount,
    this.minReceiveAmount,
    this.slippagePercent,
    this.signatureData = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? data;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? from;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? to;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? value;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? gas;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? gasPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? maxPriorityFeePerGas;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? maxSpendAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? minReceiveAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? slippagePercent;

  List<String> signatureData;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TransactionData &&
    other.data == data &&
    other.from == from &&
    other.to == to &&
    other.value == value &&
    other.gas == gas &&
    other.gasPrice == gasPrice &&
    other.maxPriorityFeePerGas == maxPriorityFeePerGas &&
    other.maxSpendAmount == maxSpendAmount &&
    other.minReceiveAmount == minReceiveAmount &&
    other.slippagePercent == slippagePercent &&
    _deepEquality.equals(other.signatureData, signatureData);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data == null ? 0 : data!.hashCode) +
    (from == null ? 0 : from!.hashCode) +
    (to == null ? 0 : to!.hashCode) +
    (value == null ? 0 : value!.hashCode) +
    (gas == null ? 0 : gas!.hashCode) +
    (gasPrice == null ? 0 : gasPrice!.hashCode) +
    (maxPriorityFeePerGas == null ? 0 : maxPriorityFeePerGas!.hashCode) +
    (maxSpendAmount == null ? 0 : maxSpendAmount!.hashCode) +
    (minReceiveAmount == null ? 0 : minReceiveAmount!.hashCode) +
    (slippagePercent == null ? 0 : slippagePercent!.hashCode) +
    (signatureData.hashCode);

  @override
  String toString() => 'TransactionData[data=$data, from=$from, to=$to, value=$value, gas=$gas, gasPrice=$gasPrice, maxPriorityFeePerGas=$maxPriorityFeePerGas, maxSpendAmount=$maxSpendAmount, minReceiveAmount=$minReceiveAmount, slippagePercent=$slippagePercent, signatureData=$signatureData]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.data != null) {
      json[r'data'] = this.data;
    } else {
      json[r'data'] = null;
    }
    if (this.from != null) {
      json[r'from'] = this.from;
    } else {
      json[r'from'] = null;
    }
    if (this.to != null) {
      json[r'to'] = this.to;
    } else {
      json[r'to'] = null;
    }
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    if (this.gas != null) {
      json[r'gas'] = this.gas;
    } else {
      json[r'gas'] = null;
    }
    if (this.gasPrice != null) {
      json[r'gasPrice'] = this.gasPrice;
    } else {
      json[r'gasPrice'] = null;
    }
    if (this.maxPriorityFeePerGas != null) {
      json[r'maxPriorityFeePerGas'] = this.maxPriorityFeePerGas;
    } else {
      json[r'maxPriorityFeePerGas'] = null;
    }
    if (this.maxSpendAmount != null) {
      json[r'maxSpendAmount'] = this.maxSpendAmount;
    } else {
      json[r'maxSpendAmount'] = null;
    }
    if (this.minReceiveAmount != null) {
      json[r'minReceiveAmount'] = this.minReceiveAmount;
    } else {
      json[r'minReceiveAmount'] = null;
    }
    if (this.slippagePercent != null) {
      json[r'slippagePercent'] = this.slippagePercent;
    } else {
      json[r'slippagePercent'] = null;
    }
      json[r'signatureData'] = this.signatureData;
    return json;
  }

  /// Returns a new [TransactionData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TransactionData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TransactionData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TransactionData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TransactionData(
        data: mapValueOfType<String>(json, r'data'),
        from: mapValueOfType<String>(json, r'from'),
        to: mapValueOfType<String>(json, r'to'),
        value: mapValueOfType<String>(json, r'value'),
        gas: mapValueOfType<String>(json, r'gas'),
        gasPrice: mapValueOfType<String>(json, r'gasPrice'),
        maxPriorityFeePerGas: mapValueOfType<String>(json, r'maxPriorityFeePerGas'),
        maxSpendAmount: mapValueOfType<String>(json, r'maxSpendAmount'),
        minReceiveAmount: mapValueOfType<String>(json, r'minReceiveAmount'),
        slippagePercent: mapValueOfType<String>(json, r'slippagePercent'),
        signatureData: json[r'signatureData'] is Iterable
            ? (json[r'signatureData'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<TransactionData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TransactionData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TransactionData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TransactionData> mapFromJson(dynamic json) {
    final map = <String, TransactionData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TransactionData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TransactionData-objects as value to a dart map
  static Map<String, List<TransactionData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TransactionData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TransactionData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

