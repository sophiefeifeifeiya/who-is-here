import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whoshere/model/user.dart';

import 'api_exceptions.dart';

class ApiBroker {
  final String apiDomain;
  final String apiBasePath;

  ApiBroker({required this.apiDomain, required this.apiBasePath});

  // All null or all not null
  UserTokenPair? accessToken;
  UserTokenPair? refreshToken;

  static const String _contentTypeJson = "application/json";

  Future<UserLoginResponse> login({required UserLoginRequest request}) async {
    try {
      Uri uri = Uri.https(apiDomain, apiBasePath + "/User/Login");
      var response = await http.post(uri,
          headers: {"Content-Type": _contentTypeJson},
          body: json.encode(request.toJson()));
      _ensureSuccessfulResponse(response);
      var userTokens = UserLoginResponse.fromJson(json.decode(response.body));
      accessToken = userTokens.accessToken;
      refreshToken = userTokens.refreshToken;
      return userTokens;
    } on SocketException catch (e) {
      throw ApiBrokerException("Network lost: ${e.message}");
    }
  }

  Future register({required UserRegistrationRequest request}) async {
    if (accessToken != null) {
      throw StateError("Cannot register a new account when signed in");
    }

    var response = await http.post(Uri.https(apiDomain, apiBasePath + "/User/Register"),
      headers: {"Content-Type": _contentTypeJson},
      body: json.encode(request.toJson())
    );
    _ensureSuccessfulResponse(response);
  }

  Future<http.Response> sendRequest(
      {required String method, required String apiPath}) async {
    var request =
        http.Request(method, Uri.https(apiDomain, apiBasePath + apiPath));

    var client = http.Client();
    try {
      if (accessToken != null) {
        var now = DateTime.now();
        // Refresh access token 2 minuets before it expired
        if (now.isAfter(
            accessToken!.expires.subtract(const Duration(minutes: 2)))) {
        } else {
          // if the access token is expired, check refresh token
          if (now.isAfter(refreshToken!.expires)) {
            // if the refresh token is expired
            throw UserTokenExpiredException();
          } else {}
        }
      }

      var response = await http.Response.fromStream(await client.send(request));
      _ensureSuccessfulResponse(response);
      return response;
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
