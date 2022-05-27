import 'dart:io';

import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';

import '../api/api_broker.dart';

class EditProfileController extends GetxController {
  final Rxn<User> user;

  final Rx<String> avaPath = ''.obs;

  ///换成空安全类型，防止出现空指针闪退
  final RxBool emailValidationError = false.obs;
  final RxBool userNameValidationError = false.obs;

  EditProfileController(this.user);

//更新用户头像方法
  void updateUserAvatarPath(String path) {
    print("进来了；$path   ${user.value == null}");
    if (user.value != null) {
      final u = user.value!;
      u.avatarPath = path;
      user.value = u;
      update();
    } else {
      ///用户为空
      avaPath.trigger(path);
    }
    Get.find<ApiBroker>().myUploadFile(File(path));
  }


  /// 请求api
}
