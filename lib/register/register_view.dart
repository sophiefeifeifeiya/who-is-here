import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/utils/size_config.dart';

import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.put(RegisterLogic());
  final state = Get.find<RegisterLogic>().state;

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterLogic>(builder: (logic) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.px,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.px),
            child: Column(
              children: [
                SizedBox(
                  height: 100.px,
                ),
                TextField(
                  controller: state.userController,
                  style: TextStyle(
                    fontSize: 16.px,
                  ),
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        state.userController.clear();
                        logic.update();
                      },
                      child: const Icon(Icons.close),
                    ),
                    hintText: 'input account',
                    hintStyle: TextStyle(
                      fontSize: 16.px,
                      color: const Color(0xffbbbbbb),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                TextField(
                  controller: state.pwdController,
                  style: TextStyle(
                    fontSize: 16.px,
                  ),
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        state.pwdController.clear();
                        logic.update();
                      },
                      child: const Icon(Icons.close),
                    ),
                    hintText: '请输入密码',
                    hintStyle: TextStyle(
                      fontSize: 16.px,
                      color: const Color(0xffbbbbbb),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.px,
                ),
                TextField(
                  controller: state.emailController,
                  style: TextStyle(
                    fontSize: 16.px,
                  ),
                  textAlignVertical: TextAlignVertical.bottom,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        state.emailController.clear();
                        logic.update();
                      },
                      child: const Icon(Icons.close),
                    ),
                    hintText: '请输入邮箱',
                    hintStyle: TextStyle(
                      fontSize: 16.px,
                      color: const Color(0xffbbbbbb),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.px,
                ),
                _button(),
              ],
            ),
          ));
    });
  }

  Widget _button() {
    return InkWell(
      onTap: () {
        logic.register();
      },
      child: Container(
        color: Colors.blue,
        width: 200.px,
        height: 40.px,
        alignment: Alignment.center,
        child: const Text(
          "注册",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
