import 'package:whoshere/api_const_key.dart';

Uri getAvatarImageUri(String avatarPath) {
  return Uri.https(ApiConstKey.apiDomain, ApiConstKey.apiPath + avatarPath);
}