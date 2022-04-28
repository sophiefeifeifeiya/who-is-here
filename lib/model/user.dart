import 'package:json_annotation/json_annotation.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

part 'user.g.dart';

class User {
  String imagePath;
  String name;
  String email;
  String about;
  bool isDarkMode;
  LatLng location;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    this.isDarkMode = false,
    this.location = const LatLng(0, 0),
  });
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
