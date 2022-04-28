import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/services.dart';
import 'package:whoshere/utils/input_validations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final IUserService userService = Get.find();

  String? email;
  String? password;
  String? username;

  bool working = false;

  handleRegister() async {
    final form = formKey.currentState;
    assert(form != null);
    form!.save();

    if (form.validate()) {
      assert(email != null);
      assert(password != null);
      assert(username != null);
      try {
        setState(() {
          working = true;
        });
        await userService.register(email!, username!, password!);
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Registered successfully. Logging you in..."),
                ));
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context); // Pop the dialog
        Get.offAllNamed(RoutePages.login,
            arguments: {"email": email, "password": password});
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
                      Text("Registration failed")
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register - Who's Here"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Form(
                key: formKey,
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
                          labelText: "Username", icon: Icon(Icons.person)),
                      enabled: !working,
                      onSaved: (value) => username = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cannot be empty";
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
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Password Confirmation",
                        icon: Icon(Icons.password),
                      ),
                      enabled: !working,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be null";
                        } else if (value != password) {
                          return "Please enter the same password";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: working ? null : handleRegister,
                          child: working
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ))
                              : const Text("Register")),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
