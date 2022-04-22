import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:whoshere/http/service/user_service.dart';
import 'package:whoshere/utils/log_util.dart';

/// 请求拦截器
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 获取用户token
    UserService userService = Get.find<UserService>();
    String token = userService.getRequestAccessToken();
    LogUtil.d("用户token：$token");
    options.headers.addAll({"token": token});
    return super.onRequest(options, handler);
  }
}
