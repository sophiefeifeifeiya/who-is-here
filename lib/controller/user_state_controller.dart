import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';

class UserStateController extends GetxController {
  final Rx<User?> currentUser = Rx<User?>(null);
}