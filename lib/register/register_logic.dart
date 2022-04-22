import 'package:get/get.dart';
import 'package:whoshere/http/service/http_service.dart';
import 'package:whoshere/utils/toast.dart';
import 'package:whoshere/utils/loading.dart';
import 'package:whoshere/utils/log_util.dart';

import 'register_state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();

  void register() async {
    String user = state.userController.text.trim();
    String pwd = state.pwdController.text.trim();
    String email = state.emailController.text.trim();
    if (user.isEmpty) {
      ToastUtil.showMessage("请输入账号");
      return;
    }
    if (user.isEmpty) {
      ToastUtil.showMessage("请输入密码");
      return;
    }
    if (user.isEmpty) {
      ToastUtil.showMessage("请输入邮箱");
      return;
    }
    Map<String, dynamic> map = {};
    map["UserName"] = user;
    map["Password"] = pwd;
    map["Email"] = email;
    LogUtil.d("参数========$map");
    LoadingUtil.show();
    HttpService.register(map).then((value) {
      LogUtil.d("注册返回========$value");
      LoadingUtil.dismiss();
      ToastUtil.showMessage("注册成功");
      Get.back();
    }).catchError((e) {
      LogUtil.d("报错了========$e");
      LoadingUtil.dismiss();
      ToastUtil.showMessage("注册失败");
    });
    // userList.add(user);
    // pwdList.add(pwd);
    // emailList.add(email);
    // ToastUtil.showMessage("注册成功");
    // Get.back();
  }
}
