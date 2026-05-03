//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TokenInfo {
  /// Returns a new [TokenInfo] instance.
  TokenInfo({
    this.decimal,
    this.tokenContractAddress,
    this.tokenSymbol,
    this.tokenUnitPrice,
    this.isHoneyPot,
    this.taxRate,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? decimal;

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
  String? tokenSymbol;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tokenUnitPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isHoneyPot;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? taxRate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TokenInfo &&
    other.decimal == decimal &&
    other.tokenContractAddress == tokenContractAddress &&
    other.tokenSymbol == tokenSymbol &&
    other.tokenUnitPrice == tokenUnitPrice &&
    other.isHoneyPot == isHoneyPot &&
    other.taxRate == taxRate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (decimal == null ? 0 : decimal!.hashCode) +
    (tokenContractAddress == null ? 0 : tokenContractAddress!.hashCode) +
    (tokenSymbol == null ? 0 : tokenSymbol!.hashCode) +
    (tokenUnitPrice == null ? 0 : tokenUnitPrice!.hashCode) +
    (isHoneyPot == null ? 0 : isHoneyPot!.hashCode) +
    (taxRate == null ? 0 : taxRate!.hashCode);

  @override
  String toString() => 'TokenInfo[decimal=$decimal, tokenContractAddress=$tokenContractAddress, tokenSymbol=$tokenSymbol, tokenUnitPrice=$tokenUnitPrice, isHoneyPot=$isHoneyPot, taxRate=$taxRate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.decimal != null) {
      json[r'decimal'] = this.decimal;
    } else {
      json[r'decimal'] = null;
    }
    if (this.tokenContractAddress != null) {
      json[r'tokenContractAddress'] = this.tokenContractAddress;
    } else {
      json[r'tokenContractAddress'] = null;
    }
    if (this.tokenSymbol != null) {
      json[r'tokenSymbol'] = this.tokenSymbol;
    } else {
      json[r'tokenSymbol'] = null;
    }
    if (this.tokenUnitPrice != null) {
      json[r'tokenUnitPrice'] = this.tokenUnitPrice;
    } else {
      json[r'tokenUnitPrice'] = null;
    }
    if (this.isHoneyPot != null) {
      json[r'isHoneyPot'] = this.isHoneyPot;
    } else {
      json[r'isHoneyPot'] = null;
    }
    if (this.taxRate != null) {
      json[r'taxRate'] = this.taxRate;
    } else {
      json[r'taxRate'] = null;
    }
    return json;
  }

  /// Returns a new [TokenInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TokenInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TokenInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TokenInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TokenInfo(
        decimal: mapValueOfType<String>(json, r'decimal'),
        tokenContractAddress: mapValueOfType<String>(json, r'tokenContractAddress'),
        tokenSymbol: mapValueOfType<String>(json, r'tokenSymbol'),
        tokenUnitPrice: mapValueOfType<String>(json, r'tokenUnitPrice'),
        isHoneyPot: mapValueOfType<bool>(json, r'isHoneyPot'),
        taxRate: mapValueOfType<String>(json, r'taxRate'),
      );
    }
    return null;
  }

  static List<TokenInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TokenInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TokenInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TokenInfo> mapFromJson(dynamic json) {
    final map = <String, TokenInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TokenInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TokenInfo-objects as value to a dart map
  static Map<String, List<TokenInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TokenInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TokenInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

