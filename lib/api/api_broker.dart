import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coord_convert/coord_convert.dart';
import 'package:http/http.dart' as http;
import 'package:whoshere/model/user.dart';

import 'api_exceptions.dart';

class ApiBroker {
  final String apiDomain;
  final String apiBasePath;
  final StreamController<UserLoginResponse> tokenRefreshController =
      StreamController<UserLoginResponse>();
  late Stream<UserLoginResponse> onTokenRefreshed;

  ApiBroker({required this.apiDomain, required this.apiBasePath}) {
    onTokenRefreshed = tokenRefreshController.stream;
  }

  // All null or all not null
  UserTokenPair? accessToken;
  UserTokenPair? refreshToken;

  static const String _contentTypeJson = "application/json";

  Future<UserLoginResponse> login({required UserLoginRequest request}) async {
    var response = await sendRequest(
        method: "POST",
        apiPath: "/User/Login",
        requireIdentity: false,
        body: json.encode(request.toJson()));
    var userTokens = UserLoginResponse.fromJson(json.decode(response.body));
    accessToken = userTokens.accessToken;
    refreshToken = userTokens.refreshToken;
    return userTokens;
  }

  Future register({required UserRegistrationRequest request}) async {
    if (accessToken != null) {
      throw StateError(
          "Cannot register a new account because already signed in");
    }

    sendRequest(
        method: "POST",
        apiPath: "/User/Register",
        requireIdentity: false,
        body: json.encode(request.toJson()));
  }

  Future<UserProfile> getProfile() async {
    if (refreshToken == null) {
      throw StateError("You must be logged in to call profile()");
    }

    var response = await sendRequest(method: "GET", apiPath: "/User/Profile");
    return UserProfile.fromJson(json.decode(response.body));
  }

  /// Get nearby users
  ///
  /// currentLocation: the coordinate of current location in WGS-084
  Future<List<User>> getNearbyUsers(Coords currentLocation) async {
    var response = await sendRequest(
        method: "GET",
        apiPath: "/UserLocation",
        body: json.encode({
          "latitude": currentLocation.latitude,
          "longitude": currentLocation.longitude
        }));
    Iterable l = json.decode(response.body);
    List<User> users = List<User>.from(l.map((j) => User.fromJson(j)));
    return users;
  }

  Future refresh() async {
    if (refreshToken == null) {
      throw StateError("You must be logged in to call profile()");
    }

    // if the refresh token is expired
    if (DateTime.now().isAfter(refreshToken!.expires)) {
      throw UserTokenExpiredException();
    }

    var response = await sendRequest(
        method: "POST",
        apiPath: "/User/Refresh",
        requireIdentity: false,
        disableRefresh: true,
        body:
            json.encode(UserRefreshTokenRequest(refreshToken!.token).toJson()));
    var userTokens = UserLoginResponse.fromJson(json.decode(response.body));
    accessToken = userTokens.accessToken;
    refreshToken = userTokens.refreshToken;
    tokenRefreshController.sink.add(userTokens);
  }

  Future<http.Response> sendRequest(
      {required String method,
      required String apiPath,
      Object? body,
      bool requireIdentity = true,
      bool disableRefresh = false,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    var request = http.Request(
        method, Uri.https(apiDomain, apiBasePath + apiPath, queryParameters));

    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is Map<String, String>) {
        request.bodyFields = body;
      } else if (body is List<int>) {
        request.bodyBytes = body;
      }
    }

    // default content-type is json
    request.headers["Content-Type"] = _contentTypeJson;
    if (headers != null) {
      headers.forEach((key, value) {
        request.headers[key] = value;
      });
    }

    var client = http.Client();
    try {
      if (accessToken != null) {
        // Refresh access token 2 minuets before it expired
        if (DateTime.now().isAfter(
            accessToken!.expires.subtract(const Duration(minutes: 2)))) {
          if (!disableRefresh) {
            await refresh();
          }
        }
      }

      if (requireIdentity) {
        request.headers["Authorization"] = "Bearer ${accessToken!.token}";
      }

      var response = await http.Response.fromStream(await client.send(request));
      _ensureSuccessfulResponse(response);
      return response;
    } on SocketException catch (e) {
      throw ApiBrokerException("Network lost: ${e.message}");
    } finally {
      client.close();
    }
  }

  void _ensureSuccessfulResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return;
      case 400:
        throw InvalidInputException(response);
      case 401:
        throw UnauthorizedException(response);
      case 403:
        throw PermissionDeniedException(response);
      case 404:
        throw NotFoundException(response);
      case 409:
        throw ConflictException(response);
      case 503:
        throw ServerUnavailableException(response);
    }
    throw ApiRequestException(response);
  }
}
