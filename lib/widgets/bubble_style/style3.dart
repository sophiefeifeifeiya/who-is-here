import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/controller/controller.dart';

class bubbleType3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
          onTap: () {
            typeChoosingController.add(3);
          },
          child: const AvatarView(
            radius: 40,
            borderWidth: 10,
            borderColor: Colors.lightBlue,
            avatarType: AvatarType.RECTANGLE,
            backgroundColor: Colors.red,
            imagePath: "assets/images/profile.jpg",
            placeHolder: Icon(
              Icons.person,
              size: 50,
            ),
            errorWidget: Icon(
              Icons.error,
              size: 50,
            ),
          )),
    );
  }
}
