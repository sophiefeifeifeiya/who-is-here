import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';

class UserStateController extends GetxController {
  final Rxn<User> currentUser = Rxn<User>(null);

  /// 语法错误
  final Rx<List<User>> otherUsers = Rx<List<User>>([]);
}
