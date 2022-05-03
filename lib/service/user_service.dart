import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/service/services.dart';

class UserService implements IUserService {
  static const String _prefsKeyAccessToken = "UserService_AccessToken";
  static const String _prefsKeyAccessTokenExpires =
      "UserService_AccessToken_Expires";
  static const String _prefsKeyRefreshToken = "UserService_RefreshToken";
  static const String _prefsKeyRefreshTokenExpires =
      "UserService_RefreshToken_Expires";

  final ApiBroker _broker = Get.find();

  UserService() {
    _broker.onTokenRefreshed.listen((event) {
      _saveToken(event.accessToken, event.refreshToken);
    });
  }

  @override
  Future<User> login(String email, String password) async {
    UserLoginResponse response =
        await _broker.login(request: UserLoginRequest(email, password));
    await _saveToken(response.accessToken, response.refreshToken);
    UserProfile profile = await _broker.getProfile();
    return User.fromUserProfile(profile);
  }

  @override
  Future register(String email, String username, String password) async {
    await _broker.register(
        request: UserRegistrationRequest(username, password, email));
  }

  @override
  Future<User?> loadLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(_prefsKeyAccessToken);
    String? refreshToken = prefs.getString(_prefsKeyRefreshToken);

    String? accessExpiresStr = prefs.getString(_prefsKeyAccessTokenExpires);
    String? refreshExpiresStr = prefs.getString(_prefsKeyRefreshTokenExpires);

    if (accessToken == null ||
        refreshToken == null ||
        accessExpiresStr == null ||
        refreshExpiresStr == null) {
      return null;
    }

    DateTime? accessExpires = DateTime.tryParse(accessExpiresStr);
    DateTime? refreshExpires = DateTime.tryParse(refreshExpiresStr);
    if (accessExpires == null || refreshExpires == null) {
      return null;
    }

    _broker.accessToken = UserTokenPair(accessToken, accessExpires);
    _broker.refreshToken = UserTokenPair(refreshToken, refreshExpires);
    UserProfile profile = await _broker.getProfile();

    return User.fromUserProfile(profile);
  }

  @override
  UserTokenPair? get accessToken => _broker.accessToken;

  @override
  UserTokenPair? get refreshToken => _broker.refreshToken;

  Future _saveToken(
      UserTokenPair accessToken, UserTokenPair refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefsKeyAccessToken, accessToken.token);
    prefs.setString(
        _prefsKeyAccessTokenExpires, accessToken.expires.toString());
    prefs.setString(_prefsKeyRefreshToken, refreshToken.token);
    prefs.setString(
        _prefsKeyRefreshTokenExpires, refreshToken.expires.toString());
  }

  @override
  Future updateUserProfile(UserProfileUpdate profile) async {
    await _broker.updateProfile(profile);
  }
}
