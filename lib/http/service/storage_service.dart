import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:whoshere/storage.dart';

class StorageService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<StorageService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  // /// 存储用户信息字符串
  Future<bool> saveUserInfo({required String userInfo}) {
    return sharedPreferences.setString(StorageConstants.userInfo, userInfo);
  }

  /// 删除用户信息字符串
  Future<bool> removeUserInfo() {
    return sharedPreferences.remove(StorageConstants.userInfo);
  }

  /// 获取用户信息字符串
  String? getUserInfo() {
    return sharedPreferences.getString(StorageConstants.userInfo);
  }
}
