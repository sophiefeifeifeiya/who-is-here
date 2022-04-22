import 'package:get/get.dart';
import 'package:whoshere/chat/chat_view.dart';
import 'package:whoshere/login/login_view.dart';
import 'package:whoshere/register/register_view.dart';

abstract class RoutePages {
  static const main = '/';
  static const login = '/login';
  static const register = '/register';
  static const chat = '/chat';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: chat, page: () => ChatPage()),
  ];
}
