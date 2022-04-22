import 'package:whoshere/generated/json/base/json_convert_content.dart';
import 'package:whoshere/model/user_info_entity.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    userInfoEntity.token = token;
  }
  final String? expiration = jsonConvert.convert<String>(json['expiration']);
  if (expiration != null) {
    userInfoEntity.expiration = expiration;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['token'] = entity.token;
  data['expiration'] = entity.expiration;
  return data;
}
