abstract class BaseException implements Exception {
  Exception? innerException;
  String errorMessage;

  BaseException(this.errorMessage, {this.innerException});
}
