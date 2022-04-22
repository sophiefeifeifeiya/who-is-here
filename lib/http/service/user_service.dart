import 'dart:convert';

import 'package:get/get.dart';
import 'package:whoshere/http/service/storage_service.dart';
import 'package:whoshere/model/user_info_entity.dart';
import 'package:whoshere/utils/log_util.dart';

class UserService extends GetxService {
  /// 是否登录
  RxBool isLogin = false.obs;

  /// 用户信息
  UserInfoEntity? _userInfoEntity;

  Future<UserService> init() async {
    try {
      StorageService storageService = Get.find<StorageService>();
      String? userInfoString = storageService.getUserInfo();
      if (userInfoString == null) {
        _userInfoEntity = null;
        isLogin.value = false;
        LogUtil.d("用户未登录");
      } else {
        final userInfo = json.decode(userInfoString);
        _userInfoEntity = UserInfoEntity.fromJson(userInfo);
        isLogin.value = true;
        LogUtil.d("用户已登录");
      }
    } catch (e) {
      LogUtil.d("用户服务出错了：$e");
      _userInfoEntity = null;
      isLogin.value = false;
    }
    return this;
  }

  /// 存储用户信息
  Future<bool> saveUserInfo({required Map<String, dynamic> userInfoMap}) async {
    try {
      _userInfoEntity = UserInfoEntity.fromJson(userInfoMap);
      String userInfoString = json.encode(userInfoMap);
      StorageService storageService = Get.find<StorageService>();
      bool success =
          await storageService.saveUserInfo(userInfo: userInfoString);
      if (success) {
        isLogin.value = true;
        return Future.value(true);
      } else {
        _userInfoEntity = null;
        isLogin.value = false;
        return Future.value(false);
      }
    } catch (e) {
      LogUtil.d("用户服务存储用户信息出错了:$e");
      return Future.value(false);
    }
  }

  /// 更新用户信息
  Future<bool> updateUserInfo(
      {required Map<String, dynamic> userInfoMap}) async {
    try {
      UserInfoEntity userInfoEntity = UserInfoEntity.fromJson(userInfoMap);
      userInfoEntity.token = _userInfoEntity?.token;
      String userInfoString = json.encode(userInfoEntity.toJson());
      StorageService storageService = Get.find<StorageService>();
      bool success =
          await storageService.saveUserInfo(userInfo: userInfoString);
      if (success) {
        isLogin.value = true;
        return Future.value(true);
      } else {
        _userInfoEntity = null;
        isLogin.value = false;
        return Future.value(false);
      }
    } catch (e) {
      LogUtil.d("用户服务存储用户信息出错了:$e");
      return Future.value(false);
    }
  }

  /// 获取用户信息
  UserInfoEntity? get userInfo => _userInfoEntity;

  /// 获取当前用户登录的-token
  String getRequestAccessToken() {
    return _userInfoEntity?.token ?? "";
  }

  /// 退出登录
  void loginOut() async {
    StorageService storageService = Get.find<StorageService>();
    bool success = await storageService.removeUserInfo();
    if (success) {
      isLogin.value = false;
      _userInfoEntity = null;
    }
  }
}
