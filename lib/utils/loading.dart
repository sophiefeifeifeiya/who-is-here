import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtil {
  static configLoadingStyle() {
    // EasyLoading.instance
    //   ..loadingStyle = EasyLoadingStyle.custom
    //   ..maskType = EasyLoadingMaskType.custom
    //   ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    //   ..progressColor = Colors.transparent
    //   ..backgroundColor = Colors.transparent
    //   ..indicatorColor = Colors.transparent
    //   ..textColor = Colors.black
    //   ..maskColor = Colors.transparent
    //   ..userInteractions = true
    //   ..dismissOnTap = true
    //   ..indicatorWidget = _buildLoadingWidget();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true;
  }

  static show({
    bool isShowMask = true,
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
    bool userInteractions = true,
  }) {
    EasyLoading.instance.maskColor = isShowMask ? Colors.black.withOpacity(0.3) : Colors.transparent;
    EasyLoading.instance.userInteractions = userInteractions;
    EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap
    );
  }

  static dismiss() {
    EasyLoading.dismiss();
  }

  static Widget _buildLoadingWidget() {
    return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 100
          ),
          child: CircularProgressIndicator()
        )
    );
  }

}