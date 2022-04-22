import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../aip.dart';
import '../http_utils.dart';

class HttpService {
  /// 登录
  static Future login(Map<String, dynamic> dataMap) async {
    final result = await HttpUtils.post(Api.login, data: dataMap);
    return result;
  }
  /// 注册
  static Future register(Map<String, dynamic> dataMap) async {
    final result = await HttpUtils.post(Api.register, data: dataMap);
    return result;
  }
}
