import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/model/user.dart';

abstract class IUserService {
  /// Attempt to login with the given email and password.
  ///
  /// Throws ApiBrokerException if login failed.
  Future login(String email, String password);

  /// Register a new account.
  ///
  /// Throws ApiBrokerException if failed.
  Future register(String email, String username, String password);

  bool get isLoggedIn;
  User? get currentUser;
  UserTokenPair? get accessToken;
  UserTokenPair? get refreshToken;
}

class UserService implements IUserService {
  static const String _prefsKeyAccessToken = "UserService_AccessToken";
  static const String _prefsKeyAccessTokenExpires =
      "UserService_AccessToken_Expires";
  static const String _prefsKeyRefreshToken = "UserService_RefreshToken";
  static const String _prefsKeyRefreshTokenExpires =
      "UserService_RefreshToken_Expires";

  static Future<UserService> createFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(_prefsKeyAccessToken);
    String? refreshToken = prefs.getString(_prefsKeyRefreshToken);

    String? accessExpiresStr = prefs.getString(_prefsKeyAccessTokenExpires);
    String? refreshExpiresStr = prefs.getString(_prefsKeyRefreshTokenExpires);

    UserService instance = UserService();
    if (accessToken == null ||
        refreshToken == null ||
        accessExpiresStr == null ||
        refreshExpiresStr == null) {
      return instance;
    }

    DateTime? accessExpires = DateTime.tryParse(accessExpiresStr);
    DateTime? refreshExpires = DateTime.tryParse(refreshExpiresStr);
    if (accessExpires == null || refreshExpires == null) {
      return instance;
    }

    instance._accessToken = UserTokenPair(accessToken, accessExpires);
    instance._refreshToken = UserTokenPair(refreshToken, refreshExpires);
    instance._user = User(
      imagePath: 'images/1.jpg',
      name: 'Kaedehara Kazuha',
      email: 'wanye@gmail.com',
      about: 'ok.',
      isDarkMode: false,
    );
    return instance;
  }

  User? _user;
  UserTokenPair? _accessToken;
  UserTokenPair? _refreshToken;

  final ApiBroker _broker = Get.find();

  @override
  User? get currentUser => _user;

  @override
  bool get isLoggedIn =>
      _refreshToken != null && _refreshToken!.expires.isAfter(DateTime.now());

  @override
  UserTokenPair? get accessToken => _accessToken;

  @override
  UserTokenPair? get refreshToken => _refreshToken;

  @override
  Future login(String email, String password) async {
    UserLoginResponse response =
        await _broker.login(request: UserLoginRequest(email, password));
    _accessToken = response.accessToken;
    _refreshToken = response.refreshToken;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefsKeyAccessToken, response.accessToken.token);
    prefs.setString(
        _prefsKeyAccessTokenExpires, response.accessToken.expires.toString());
    prefs.setString(_prefsKeyRefreshToken, response.refreshToken.token);
    prefs.setString(
        _prefsKeyRefreshTokenExpires, response.refreshToken.expires.toString());
  }

  @override
  Future register(String email, String username, String password) async {
    await _broker.register(
        request: UserRegistrationRequest(username, password, email));
  }
}
