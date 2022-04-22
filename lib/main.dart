// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:whoshere/page/home_page.dart';
import 'package:whoshere/utils/dependency_injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whoshere/utils/storage.dart';
import 'http/http_config.dart';
import 'http/http_utils.dart';
import 'utils/size_config.dart';
import 'package:whoshere/routes/routes.dart';
import 'package:get/get.dart';

void main() async {
  ///不加存储报错
  WidgetsFlutterBinding.ensureInitialized();

  /// 等待依赖服务初始化
  await DependencyInjection.init();

  /// 适配工具初始化
  SizeConfig.initialize();

  /// 网络接口配置
  HttpUtils.init(httpState: HttpState.release);

  ///初始化存储
  await SpUtil().init();
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
      title: "Who's here",
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
      builder: (BuildContext context, Widget? child) {
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
