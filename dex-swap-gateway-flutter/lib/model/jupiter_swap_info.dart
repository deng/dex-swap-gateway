//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class JupiterSwapInfo {
  /// Returns a new [JupiterSwapInfo] instance.
  JupiterSwapInfo({
    this.ammKey,
    this.label,
    this.inputMint,
    this.outputMint,
    this.inAmount,
    this.outAmount,
    this.feeAmount,
    this.feeMint,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? ammKey;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? label;

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
  String? outputMint;

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
  String? outAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? feeAmount;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? feeMint;

  @override
  bool operator ==(Object other) => identical(this, other) || other is JupiterSwapInfo &&
    other.ammKey == ammKey &&
    other.label == label &&
    other.inputMint == inputMint &&
    other.outputMint == outputMint &&
    other.inAmount == inAmount &&
    other.outAmount == outAmount &&
    other.feeAmount == feeAmount &&
    other.feeMint == feeMint;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (ammKey == null ? 0 : ammKey!.hashCode) +
    (label == null ? 0 : label!.hashCode) +
    (inputMint == null ? 0 : inputMint!.hashCode) +
    (outputMint == null ? 0 : outputMint!.hashCode) +
    (inAmount == null ? 0 : inAmount!.hashCode) +
    (outAmount == null ? 0 : outAmount!.hashCode) +
    (feeAmount == null ? 0 : feeAmount!.hashCode) +
    (feeMint == null ? 0 : feeMint!.hashCode);

  @override
  String toString() => 'JupiterSwapInfo[ammKey=$ammKey, label=$label, inputMint=$inputMint, outputMint=$outputMint, inAmount=$inAmount, outAmount=$outAmount, feeAmount=$feeAmount, feeMint=$feeMint]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.ammKey != null) {
      json[r'ammKey'] = this.ammKey;
    } else {
      json[r'ammKey'] = null;
    }
    if (this.label != null) {
      json[r'label'] = this.label;
    } else {
      json[r'label'] = null;
    }
    if (this.inputMint != null) {
      json[r'inputMint'] = this.inputMint;
    } else {
      json[r'inputMint'] = null;
    }
    if (this.outputMint != null) {
      json[r'outputMint'] = this.outputMint;
    } else {
      json[r'outputMint'] = null;
    }
    if (this.inAmount != null) {
      json[r'inAmount'] = this.inAmount;
    } else {
      json[r'inAmount'] = null;
    }
    if (this.outAmount != null) {
      json[r'outAmount'] = this.outAmount;
    } else {
      json[r'outAmount'] = null;
    }
    if (this.feeAmount != null) {
      json[r'feeAmount'] = this.feeAmount;
    } else {
      json[r'feeAmount'] = null;
    }
    if (this.feeMint != null) {
      json[r'feeMint'] = this.feeMint;
    } else {
      json[r'feeMint'] = null;
    }
    return json;
  }

  /// Returns a new [JupiterSwapInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static JupiterSwapInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "JupiterSwapInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "JupiterSwapInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return JupiterSwapInfo(
        ammKey: mapValueOfType<String>(json, r'ammKey'),
        label: mapValueOfType<String>(json, r'label'),
        inputMint: mapValueOfType<String>(json, r'inputMint'),
        outputMint: mapValueOfType<String>(json, r'outputMint'),
        inAmount: mapValueOfType<String>(json, r'inAmount'),
        outAmount: mapValueOfType<String>(json, r'outAmount'),
        feeAmount: mapValueOfType<String>(json, r'feeAmount'),
        feeMint: mapValueOfType<String>(json, r'feeMint'),
      );
    }
    return null;
  }

  static List<JupiterSwapInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <JupiterSwapInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = JupiterSwapInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, JupiterSwapInfo> mapFromJson(dynamic json) {
    final map = <String, JupiterSwapInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = JupiterSwapInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of JupiterSwapInfo-objects as value to a dart map
  static Map<String, List<JupiterSwapInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<JupiterSwapInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = JupiterSwapInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

