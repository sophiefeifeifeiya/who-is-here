import 'package:get/get.dart';
import 'package:whoshere/chat/chat_view.dart';
import 'package:whoshere/page/login_page.dart';
import 'package:whoshere/page/home_page.dart';
import 'package:whoshere/page/register_page.dart';

abstract class RoutePages {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const chat = '/chat';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: chat, page: () => ChatPage()),
    GetPage(name: home, page: () => const HomePage(title: "Who's here"))
  ];
}
