
class HttpConfig {

  /// 接口环境 release uat test debug
  static late final HttpState httpState;

  /// baseUrl
  static String get baseUrl {
    switch(httpState) {
      case HttpState.release: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.uat: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.test: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.debug: {
        return "https://whoshere.fuiyoo.tech/";
      }
    }
  }

  /// imageDomain
  static String get imageDomain {
    switch(httpState) {
      case HttpState.release: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.uat: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.test: {
        return "https://whoshere.fuiyoo.tech/";
      }
      case HttpState.debug: {
        return "https://whoshere.fuiyoo.tech/";
      }
    }
  }

  static Map<String, dynamic> get httpHeaders {
    return {
      'Accept': 'application/j-son,*/*',
      'Content-Type': 'application/json',
    };
  }

  static const int connectTimeout = 60000;
  static const int receiveTimeout = 60000;
  static const int sendTimeout = 60000;

  /// 网络变化是否重试
  static bool retryEnable = true;

  /// 是否启用缓存
  static const bool cacheEnable = true;

  /// 缓存的最长时间，单位（秒）
  static const int cacheMaxAge = 10;

  /// 最大缓存数
  static const int cacheMaxCount = 100;
}

enum HttpState {
  release,
  uat,
  test,
  debug,
}