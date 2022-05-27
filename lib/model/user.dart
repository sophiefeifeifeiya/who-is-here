
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userId;
  String avatarPath;
  String userName;
  String email;
  String bio;
  bool isDarkMode;
  @JsonKey(fromJson: _locationFromJson, toJson: _locationToJson)
  LatLng location;
  late RxList<String> tags;

  User(
      {required this.userId,
      required this.avatarPath,
      required this.userName,
      required this.email,
      required this.bio,
      this.isDarkMode = false,
      this.location = const LatLng(0, 0),
      List<String>? tags}) {
    this.tags = <String>[].obs;
    if (tags != null) {
      this.tags.addAll(tags);
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static LatLng _locationFromJson(Map<String, dynamic> json) {
    num latitude = json["latitude"];
    num longitude = json["longitude"];
    return LatLng(latitude.toDouble(), longitude.toDouble());
  }

  static Map<String, dynamic> _locationToJson(LatLng location) {
    return {"latitude": location.latitude, "longitude": location.longitude};
  }

  UserProfile toUserProfile() => UserProfile(
      userId: userId,
      avatarPath: avatarPath,
      bio: bio,
      email: email,
      userName: userName,
      tags: tags.value);

  factory User.fromUserProfile(UserProfile profile) => User(
      userId: profile.userId,
      avatarPath: profile.avatarPath,
      userName: profile.userName,
      email: profile.email,
      bio: profile.bio,
      tags: profile.tags.obs);

  User copyWith({
    String? userId,
    String? avatarPath,
    String? userName,
    String? email,
    String? bio,
    bool? isDarkMode,
    LatLng? location,
    List<String>? tags,
  }) {
    return User(
      userId: userId ?? this.userId,
      avatarPath: avatarPath ?? this.avatarPath,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      location: location ?? this.location,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, email: $email, bio: $bio, avatarPath: $avatarPath, isDarkMode: $isDarkMode, location: $location, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userId == userId &&
        other.avatarPath == avatarPath &&
        other.userName == userName &&
        other.email == email &&
        other.bio == bio &&
        other.isDarkMode == isDarkMode &&
        other.location == location &&
        other.tags == tags;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        avatarPath.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        isDarkMode.hashCode ^
        location.hashCode ^
        tags.hashCode;
  }
}

extension UserUpdating on Rx<User?> {
  updateUserProfile(UserProfileUpdate profileUpdate) {
    update((u) {
      if (u == null) {
        return;
      }
      if (profileUpdate.avatarPath != null) {
        u.avatarPath = profileUpdate.avatarPath!;
      }
      if (profileUpdate.userName != null) {
        u.userName = profileUpdate.userName!;
      }
      if (profileUpdate.email != null) {
        u.email = profileUpdate.email!;
      }
      if (profileUpdate.bio != null) {
        u.bio = profileUpdate.bio!;
      }
    });
  }
}

@JsonSerializable()
class UserProfile {
  final String userId;
  final String avatarPath;
  final String userName;
  final String email;
  final String bio;
  final List<String> tags;

  UserProfile(
      {required this.userId,
      required this.avatarPath,
      required this.userName,
      required this.email,
      required this.bio,
      required this.tags});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UserProfileUpdate {
  final String? avatarPath;
  final String? userName;
  final String? email;
  final String? bio;

  UserProfileUpdate({this.avatarPath, this.userName, this.email, this.bio});

  factory UserProfileUpdate.fromUserProfile(
          UserProfile currentProfile, UserProfile updatedProfile) =>
      UserProfileUpdate(
          avatarPath: currentProfile.avatarPath != updatedProfile.avatarPath
              ? updatedProfile.avatarPath
              : null,
          userName: currentProfile.userName != updatedProfile.userName
              ? updatedProfile.userName
              : null,
          email: currentProfile.email != updatedProfile.email
              ? updatedProfile.email
              : null,
          bio: currentProfile.bio != updatedProfile.bio
              ? updatedProfile.bio
              : null);

  factory UserProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserProfileUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileUpdateToJson(this);
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
