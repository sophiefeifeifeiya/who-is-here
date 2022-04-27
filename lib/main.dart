// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/user_service.dart';

void main() async {
  // Register services and configure dependencies
  String apiDomain = const String.fromEnvironment("WHOSHERE_API_DOMAIN",
      defaultValue: "whoshere.fuiyoo.tech");
  String apiPath =
      const String.fromEnvironment("WHOSHERE_API_BASE", defaultValue: "");
  Get.put<ApiBroker>(ApiBroker(apiDomain: apiDomain, apiBasePath: apiPath),
      permanent: true);

  // Needed before loading from share preferences
  WidgetsFlutterBinding.ensureInitialized();
  UserService userService = await UserService.createFromSharedPreference();
  Get.put<IUserService>(userService, permanent: true);

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Who's here",
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: "Who's Here"),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Who's Here",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.native,
      initialRoute: RoutePages.login,
      getPages: RoutePages.pages,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en")],
      builder: EasyLoading.init(),
    );
  }
}
