// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/api_const_key.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/semi_mock_user_location_service.dart';
import 'package:whoshere/service/user_chat_service.dart';
import 'package:whoshere/service/user_service.dart';

import 'service/services.dart';

void main() async {
  // Register services and configure dependencies
  Get.put<ApiBroker>(
      ApiBroker(
          apiDomain: ApiConstKey.apiDomain,
          apiBasePath: ApiConstKey.apiPath,
          useSecureContext: ApiConstKey.useSecureContext,
          apiPort: ApiConstKey.apiPort == 0 ? null : ApiConstKey.apiPort),
      permanent: true);
  // Needed before loading from share preferences
  WidgetsFlutterBinding.ensureInitialized();
  // permanent because only 1 logged-in account is allowed at the same time
  Get.put<IUserService>(UserService(), permanent: true);

  Get.put<IUserLocationService>(SemiMockUserLocationService());

  Get.put<UserStateController>(UserStateController(), permanent: true);
  Get.put<IUserChatService>(UserChatService(), permanent: true);

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
