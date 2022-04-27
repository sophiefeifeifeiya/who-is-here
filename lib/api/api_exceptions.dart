import 'package:http/http.dart';
import 'package:whoshere/base_exception.dart';

class ApiBrokerException extends BaseException {
  ApiBrokerException(String errorMessage) : super(errorMessage);
}

class UserTokenExpiredException extends ApiBrokerException {
  UserTokenExpiredException() : super("User's token have been expired");
}

class ApiRequestException extends ApiBrokerException {
  Response response;

  ApiRequestException(this.response) : super(response.body);

  @override
  String toString() {
    return "Backend API returns an error. status code: ${response.statusCode}\n" +
        "Response content: ${response.body}";
  }
}

class InvalidInputException extends ApiRequestException {
  InvalidInputException(Response response) : super(response);
}

class UnauthorizedException extends ApiRequestException {
  UnauthorizedException(Response response) : super(response);
}

class PermissionDeniedException extends ApiRequestException {
  PermissionDeniedException(Response response) : super(response);
}

class NotFoundException extends ApiRequestException {
  NotFoundException(Response response) : super(response);
}

class ConflictException extends ApiRequestException {
  ConflictException(Response response) : super(response);
}

class ServerUnavailableException extends ApiRequestException {
  ServerUnavailableException(Response response) : super(response);
}

class UserAlreadyExistsException extends ApiRequestException {
  UserAlreadyExistsException(Response response) : super(response);
}
