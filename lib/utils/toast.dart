import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
    );
  }
}
