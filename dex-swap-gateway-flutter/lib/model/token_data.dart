//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TokenData {
  /// Returns a new [TokenData] instance.
  TokenData({
    this.decimals,
    this.tokenContractAddress,
    this.tokenLogoUrl,
    this.tokenName,
    this.tokenSymbol,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? decimals;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenContractAddress;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenLogoUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenName;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenSymbol;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TokenData &&
    other.decimals == decimals &&
    other.tokenContractAddress == tokenContractAddress &&
    other.tokenLogoUrl == tokenLogoUrl &&
    other.tokenName == tokenName &&
    other.tokenSymbol == tokenSymbol;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (decimals == null ? 0 : decimals!.hashCode) +
    (tokenContractAddress == null ? 0 : tokenContractAddress!.hashCode) +
    (tokenLogoUrl == null ? 0 : tokenLogoUrl!.hashCode) +
    (tokenName == null ? 0 : tokenName!.hashCode) +
    (tokenSymbol == null ? 0 : tokenSymbol!.hashCode);

  @override
  String toString() => 'TokenData[decimals=$decimals, tokenContractAddress=$tokenContractAddress, tokenLogoUrl=$tokenLogoUrl, tokenName=$tokenName, tokenSymbol=$tokenSymbol]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.decimals != null) {
      json[r'decimals'] = this.decimals;
    } else {
      json[r'decimals'] = null;
    }
    if (this.tokenContractAddress != null) {
      json[r'tokenContractAddress'] = this.tokenContractAddress;
    } else {
      json[r'tokenContractAddress'] = null;
    }
    if (this.tokenLogoUrl != null) {
      json[r'tokenLogoUrl'] = this.tokenLogoUrl;
    } else {
      json[r'tokenLogoUrl'] = null;
    }
    if (this.tokenName != null) {
      json[r'tokenName'] = this.tokenName;
    } else {
      json[r'tokenName'] = null;
    }
    if (this.tokenSymbol != null) {
      json[r'tokenSymbol'] = this.tokenSymbol;
    } else {
      json[r'tokenSymbol'] = null;
    }
    return json;
  }

  /// Returns a new [TokenData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TokenData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TokenData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TokenData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TokenData(
        decimals: mapValueOfType<String>(json, r'decimals'),
        tokenContractAddress: mapValueOfType<String>(json, r'tokenContractAddress'),
        tokenLogoUrl: mapValueOfType<String>(json, r'tokenLogoUrl'),
        tokenName: mapValueOfType<String>(json, r'tokenName'),
        tokenSymbol: mapValueOfType<String>(json, r'tokenSymbol'),
      );
    }
    return null;
  }

  static List<TokenData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TokenData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TokenData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TokenData> mapFromJson(dynamic json) {
    final map = <String, TokenData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TokenData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TokenData-objects as value to a dart map
  static Map<String, List<TokenData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TokenData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TokenData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

