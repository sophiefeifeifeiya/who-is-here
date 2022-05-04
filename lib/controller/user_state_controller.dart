import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';

class UserStateController extends GetxController {
  final Rx<User?> currentUser = Rx<User?>(null);
  final Rx<List<User>> otherUsers = Rx<List<User>>([]);
}
