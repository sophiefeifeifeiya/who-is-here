import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import 'package:whoshere/http/service/user_service.dart';
import 'package:whoshere/routes/routes.dart';
import 'package:whoshere/utils/log_util.dart';

/// 响应拦截器
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map) {
      Map responseData = response.data;
      if (responseData["code"] == 200) {
        String originDataString = responseData["data"];
        try {
          final dataMap = json.decode(originDataString);
          response.data["data"] = dataMap;
        } catch (e) {
          LogUtil.d("解密出错了：$e");
        }
      }
      if (responseData["code"] == 201) {
        UserService userService = get_x.Get.find<UserService>();
        if (userService.isLogin.isTrue) {
          userService.loginOut();
        }
        get_x.Get.toNamed(RoutePages.login);
      }
    }
    super.onResponse(response, handler);
  }
}
