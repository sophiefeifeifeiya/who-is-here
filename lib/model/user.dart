import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
}

@JsonSerializable()
class UserLoginRequest {
  String email;
  String password;

  UserLoginRequest(this.email, this.password);

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginRequestToJson(this);
}

@JsonSerializable()
class UserLoginResponse {
  UserTokenPair accessToken;
  UserTokenPair refreshToken;

  UserLoginResponse(this.accessToken, this.refreshToken);

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}

@JsonSerializable()
class UserTokenPair {
  String token;
  DateTime expires;

  UserTokenPair(this.token, this.expires);

  factory UserTokenPair.fromJson(Map<String, dynamic> json) =>
      _$UserTokenPairFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenPairToJson(this);
}

@JsonSerializable()
class UserRegistrationRequest {
  String userName;
  String password;
  String email;

  UserRegistrationRequest(this.userName, this.password, this.email);

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);
}
