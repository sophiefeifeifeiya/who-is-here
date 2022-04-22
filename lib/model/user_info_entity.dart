import 'dart:convert';
import 'package:whoshere/generated/json/base/json_field.dart';
import 'package:whoshere/generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity {
  String? token;
  String? expiration;

  UserInfoEntity();

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      $UserInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
