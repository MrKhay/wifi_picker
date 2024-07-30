// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NfcData {
  String? security;
  String? name;
  String? password;
  NfcData({
    this.security,
    this.name,
    this.password,
  });

  NfcData copyWith({
    String? security,
    String? name,
    String? password,
  }) {
    return NfcData(
      security: security ?? this.security,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'security': security,
      'name': name,
      'password': password,
    };
  }

  factory NfcData.fromMap(Map<String, dynamic> map) {
    return NfcData(
      security: map['security'] != null ? map['security'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfcData.fromJson(String source) =>
      NfcData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NfcData(security: $security, name: $name, password: $password)';

  @override
  bool operator ==(covariant NfcData other) {
    if (identical(this, other)) return true;

    return other.security == security &&
        other.name == name &&
        other.password == password;
  }

  @override
  int get hashCode => security.hashCode ^ name.hashCode ^ password.hashCode;
}
