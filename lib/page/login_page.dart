import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/services.dart';
import 'package:whoshere/utils/input_validations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final IUserService userService = Get.find();
  final UserStateController userStateController = Get.find();

  String? email;
  String? password;
  bool working = false;

  @override
  void initState() {
    super.initState();
    tryAutoLogin();
  }

  void tryAutoLogin() async {
    User? user = await userService.loadLoggedInUser();
    if (user != null) {
      userStateController.currentUser.value = user;
      Get.offAllNamed(RoutePages.home);
      return;
    }

    var arguments = Get.arguments;
    if (arguments != null) {
      String? email = Get.arguments["email"];
      String? password = Get.arguments["password"];

      if (email != null && password != null) {
        login(email, password);
      }
    }
  }

  Future login(String email, String password) async {
    try {
      setState(() {
        working = true;
      });
      User user = await userService.login(email, password);
      userStateController.currentUser.value = user;
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
      child: ListView(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
              child: Padding(
            // Because of the question mark, the logo looks a little to the left
            // So we move a little to the right to make the logo look like it is centered
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset("images/brand.svg"),
          )),
          const SizedBox(
            height: 50,
          ),
          Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email", icon: Icon(Icons.email)),
                    enabled: !working,
                    onSaved: (value) => email = value,
                    validator: (value) {
                      if (value == null || !value.isValidEmail()) {
                        return "Please enter a valid email address";
                      }
                      return null;
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
                      return null;
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
            height: 20,
          ),
          TextButton(
              onPressed: handleForgotPassword,
              child: const Text("Forgot password")),
          TextButton(
              onPressed: handleRegisterNewAccount,
              child: const Text("Register new account")),
        ],
      ),
    ));
  }
}
