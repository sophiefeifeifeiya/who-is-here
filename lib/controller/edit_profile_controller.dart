import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';

class EditProfileController extends GetxController {
  final Rx<User> user;
  final RxBool emailValidationError = false.obs;
  final RxBool userNameValidationError = false.obs;

  EditProfileController(this.user);
}
