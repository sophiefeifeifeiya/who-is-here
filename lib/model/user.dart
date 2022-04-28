import 'package:json_annotation/json_annotation.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

part 'user.g.dart';

class User {
  String avatarPath;
  String name;
  String email;
  String about;
  bool isDarkMode;
  LatLng location;

  User({
    required this.avatarPath,
    required this.name,
    required this.email,
    required this.about,
    this.isDarkMode = false,
    this.location = const LatLng(0, 0),
  });
}

@JsonSerializable()
class UserProfile {
  final String avatarPath;
  final String userName;
  final String email;
  final String bio;

  UserProfile(this.avatarPath, this.userName, this.email, this.bio);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UserLoginRequest {
  final String email;
  final String password;

  UserLoginRequest(this.email, this.password);

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRequestToJson(this);
}

@JsonSerializable()
class UserLoginResponse {
  final UserTokenPair accessToken;
  final UserTokenPair refreshToken;

  UserLoginResponse(this.accessToken, this.refreshToken);

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}

@JsonSerializable()
class UserTokenPair {
  final String token;
  final DateTime expires;

  UserTokenPair(this.token, this.expires);

  factory UserTokenPair.fromJson(Map<String, dynamic> json) =>
      _$UserTokenPairFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenPairToJson(this);
}

@JsonSerializable()
class UserRegistrationRequest {
  final String userName;
  final String password;
  final String email;

  UserRegistrationRequest(this.userName, this.password, this.email);

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);
}

@JsonSerializable()
class UserRefreshTokenRequest {
  final String refreshToken;

  UserRefreshTokenRequest(this.refreshToken);

  factory UserRefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefreshTokenRequestToJson(this);

}
