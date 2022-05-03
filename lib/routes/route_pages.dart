import 'package:get/get.dart';
import 'package:whoshere/page/chat_page.dart';
import 'package:whoshere/page/edit_profile_page.dart';
import 'package:whoshere/page/login_page.dart';
import 'package:whoshere/page/home_page.dart';
import 'package:whoshere/page/profile_page.dart';
import 'package:whoshere/page/register_page.dart';

abstract class RoutePages {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const chat = '/chat';
  static const profile = "/profile";
  static const editProfile = "/profile/edit";

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: chat, page: () => ChatPage()),
    GetPage(name: home, page: () => const HomePage(title: "Who's here")),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: editProfile, page: () => EditProfilePage())
  ];
}
