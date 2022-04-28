import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/controller/controller.dart';

class BubbleType3 extends StatelessWidget {
  final String avatarUrl;

  const BubbleType3({Key? key, required this.avatarUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
          child: AvatarView(
        radius: 40,
        borderWidth: 10,
        borderColor: Colors.lightBlue,
        avatarType: AvatarType.RECTANGLE,
        backgroundColor: Colors.red,
        imagePath: avatarUrl,
        placeHolder: const Icon(
          Icons.person,
          size: 50,
        ),
        errorWidget: const Icon(
          Icons.error,
          size: 50,
        ),
      )),
    );
  }
}
