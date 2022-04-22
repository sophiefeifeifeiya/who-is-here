import 'package:get/get.dart';
import 'package:whoshere/http/service/http_service.dart';
import 'package:whoshere/routes/routes.dart';
import 'package:whoshere/utils/loading.dart';
import 'package:whoshere/utils/log_util.dart';

import '../utils/toast.dart';
import 'login_state.dart';

class LoginPageLogic extends GetxController {
  final LoginPageState state = LoginPageState();

  void login() async {
    String user = state.userController.text.trim();
    String pwd = state.pwdController.text.trim();
    // user = "123456@qq.com";
    // pwd = "Qq123456_";
    if (user.isEmpty) {
      ToastUtil.showMessage("please input accoount");
      return;
    }
    if (user.isEmpty) {
      ToastUtil.showMessage("pass");
      return;
    }
    Map<String, dynamic> map = {};
    map["Email"] = user;
    map["Password"] = pwd;
    LogUtil.d("参数========$map");
    LoadingUtil.show();
    HttpService.login(map).then((value) {
      LogUtil.d("登录返回========$value");
      LoadingUtil.dismiss();
      ToastUtil.showMessage("登录成功");
      Get.toNamed(RoutePages.home);
    }).catchError((e) {
      LogUtil.d("报错了========$e");
      LoadingUtil.dismiss();
      ToastUtil.showMessage("账号或密码错误");
    });
  }
}
