import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/page/friend_page.dart';
import 'package:whoshere/widgets/emojis.dart';

class GreetingPage extends StatelessWidget {
  final Rx<User> user;

  const GreetingPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          alignment: Alignment.topCenter,
          // width: 300,
          child: hello_bar(
            user: user,
          ),
        ),
        Positioned(
          top: 30,
          left: 1,
          right: 1,
          child: SizedBox(
            height: 400,
            width: 430,
            child: gridView(),
          ),
        ),
      ],
    );
  }
}
