import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/user_service.dart';
import 'package:whoshere/utils/input_validations.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final IUserService userService = Get.find();

  String? email;
  String? password;
  bool working = false;

  @override
  void initState() {
    super.initState();

    // Auto login
    // if (userService.isLoggedIn) {
    //   redirect(); // do not await
    //   return;
    // }

    var arguments = Get.arguments;
    if (arguments != null) {
      String? email = Get.arguments["email"];
      String? password = Get.arguments["password"];

      if (email != null && password != null ) {
        login(email, password);
      }
    }
  }

  Future redirect() async {
    Future.microtask(() => Get.offAllNamed(RoutePages.home));
  }

  Future login(String email, String password) async {
    try {
      setState(() {
        working = true;
      });
      await userService.login(email, password);
      Get.offAllNamed(RoutePages.home);
    } on ApiBrokerException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.error_outline),
                SizedBox(
                  width: 15,
                ),
                Text("Login failed")
              ],
            ),
            content: Text(e.errorMessage),
          ));
    } finally {
      setState(() {
        working = false;
      });
    }
  }

  void handleLoginButton() async {
    final form = _loginFormKey.currentState;
    assert(form != null);
    form!.save();

    if (form.validate()) {
      assert(email != null);
      assert(password != null);
      await login(email!, password!);
    }
  }

  void handleForgotPassword() {
    // Navigator.pushNamed(context, "/PasswordReset");
  }

  void handleRegisterNewAccount() {
    Get.toNamed(RoutePages.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(child: SvgPicture.asset("images/brand.svg")),
          const SizedBox(
            height: 50,
          ),
          Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email", icon: Icon(Icons.email)),
                    enabled: !working,
                    onSaved: (value) => email = value,
                    validator: (value) {
                      if (value == null || !value.isValidEmail()) {
                        return "Please enter a valid email address";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.password),
                    ),
                    enabled: !working,
                    obscureText: true,
                    onSaved: (value) => password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password cannot be null";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: working ? null : handleLoginButton,
                        child: working
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ))
                            : const Text("Login")),
                  ),
                ],
              )),
          const SizedBox(
            height: 50,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Forgot password",
                style: const TextStyle(color: Colors.blueAccent),
                recognizer: TapGestureRecognizer()
                  ..onTap = handleForgotPassword),
          ])),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Register new account",
                style: const TextStyle(color: Colors.blueAccent),
                recognizer: TapGestureRecognizer()
                  ..onTap = handleRegisterNewAccount),
          ])),
        ],
      ),
    ));
  }
}
