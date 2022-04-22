import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whoshere/utils/size_config.dart';

class ToastUtil {
  static showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16.px,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
    );
  }
}
