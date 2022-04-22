import 'package:get/get.dart';
import 'package:whoshere/http/service/storage_service.dart';
import 'package:whoshere/http/service/user_service.dart';

import 'log_util.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    await Get.putAsync(() => UserService().init());
    LogUtil.d("All services started...");
  }
}
