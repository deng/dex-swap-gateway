//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class JupiterExecuteResponse {
  /// Returns a new [JupiterExecuteResponse] instance.
  JupiterExecuteResponse({
    this.signature,
    this.status,
    this.error,
  });

  /// 链上交易签名
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? signature;

  JupiterExecuteResponseStatusEnum? status;

  String? error;

  @override
  bool operator ==(Object other) => identical(this, other) || other is JupiterExecuteResponse &&
    other.signature == signature &&
    other.status == status &&
    other.error == error;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (signature == null ? 0 : signature!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (error == null ? 0 : error!.hashCode);

  @override
  String toString() => 'JupiterExecuteResponse[signature=$signature, status=$status, error=$error]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.signature != null) {
      json[r'signature'] = this.signature;
    } else {
      json[r'signature'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    return json;
  }

  /// Returns a new [JupiterExecuteResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static JupiterExecuteResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "JupiterExecuteResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "JupiterExecuteResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return JupiterExecuteResponse(
        signature: mapValueOfType<String>(json, r'signature'),
        status: JupiterExecuteResponseStatusEnum.fromJson(json[r'status']),
        error: mapValueOfType<String>(json, r'error'),
      );
    }
    return null;
  }

  static List<JupiterExecuteResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <JupiterExecuteResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = JupiterExecuteResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, JupiterExecuteResponse> mapFromJson(dynamic json) {
    final map = <String, JupiterExecuteResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = JupiterExecuteResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of JupiterExecuteResponse-objects as value to a dart map
  static Map<String, List<JupiterExecuteResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<JupiterExecuteResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = JupiterExecuteResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class JupiterExecuteResponseStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const JupiterExecuteResponseStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const success = JupiterExecuteResponseStatusEnum._(r'Success');
  static const failed = JupiterExecuteResponseStatusEnum._(r'Failed');

  /// List of all possible values in this [enum][JupiterExecuteResponseStatusEnum].
  static const values = <JupiterExecuteResponseStatusEnum>[
    success,
    failed,
  ];

  static JupiterExecuteResponseStatusEnum? fromJson(dynamic value) => JupiterExecuteResponseStatusEnumTypeTransformer().decode(value);

  static List<JupiterExecuteResponseStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <JupiterExecuteResponseStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = JupiterExecuteResponseStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [JupiterExecuteResponseStatusEnum] to String,
/// and [decode] dynamic data back to [JupiterExecuteResponseStatusEnum].
class JupiterExecuteResponseStatusEnumTypeTransformer {
  factory JupiterExecuteResponseStatusEnumTypeTransformer() => _instance ??= const JupiterExecuteResponseStatusEnumTypeTransformer._();

  const JupiterExecuteResponseStatusEnumTypeTransformer._();

  String encode(JupiterExecuteResponseStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a JupiterExecuteResponseStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  JupiterExecuteResponseStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Success': return JupiterExecuteResponseStatusEnum.success;
        case r'Failed': return JupiterExecuteResponseStatusEnum.failed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [JupiterExecuteResponseStatusEnumTypeTransformer] instance.
  static JupiterExecuteResponseStatusEnumTypeTransformer? _instance;
}


