// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthModel {
  final String accessToken;
  final String refreshToken;

  AuthModel(this.accessToken, this.refreshToken);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      map['accessToken'] as String,
      map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
