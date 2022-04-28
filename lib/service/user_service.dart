import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/model/user.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:whoshere/service/services.dart';

class UserService implements IUserService {
  static const String _prefsKeyAccessToken = "UserService_AccessToken";
  static const String _prefsKeyAccessTokenExpires =
      "UserService_AccessToken_Expires";
  static const String _prefsKeyRefreshToken = "UserService_RefreshToken";
  static const String _prefsKeyRefreshTokenExpires =
      "UserService_RefreshToken_Expires";

  final ApiBroker _broker = Get.find();

  @override
  Future<User> login(String email, String password) async {
    UserLoginResponse response =
        await _broker.login(request: UserLoginRequest(email, password));

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefsKeyAccessToken, response.accessToken.token);
    prefs.setString(
        _prefsKeyAccessTokenExpires, response.accessToken.expires.toString());
    prefs.setString(_prefsKeyRefreshToken, response.refreshToken.token);
    prefs.setString(
        _prefsKeyRefreshTokenExpires, response.refreshToken.expires.toString());

    return User(
        imagePath: "images/1.jpg",
        name: "Kaedehara Kazuha",
        email: "wanye@gmail.com",
        about: "ok.");
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

    return User(
        imagePath: "images/1.jpg",
        name: "Kaedehara Kazuha",
        email: "wanye@gmail.com",
        about: "ok.");
  }

  @override
  UserTokenPair? get accessToken => _broker.accessToken;

  @override
  UserTokenPair? get refreshToken => _broker.refreshToken;
}
