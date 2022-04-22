// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/widgets/bubble_style/style1.dart';
import 'package:whoshere/widgets/bubble_style/style2.dart';
import 'package:whoshere/widgets/bubble_style/style3.dart';

// TODO: add bubble style Enum
// Enum BubbleStyle {
// }

class Bubble extends StatelessWidget {
  final String avatar;
  final int style;
  final VoidCallback? cb;
  const Bubble(
      {Key? key, this.avatar = 'images/avatar.png', this.style = 1, this.cb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case 1:
        if (cb != null) {
          return makeTouchable(buildBubble1(avatar), cb as VoidCallback);
        } else {
          return buildBubble1(avatar);
        }
      case 2:
        if (cb != null) {
          return makeTouchable(buildBubble2(avatar), cb as VoidCallback);
        } else {
          return buildBubble2(avatar);
        }
      case 3:
        if (cb != null) {
          return makeTouchable(buildBubble3(avatar), cb as VoidCallback);
        } else {
          return buildBubble3(avatar);
        }
      default:
        return Container();
    }
  }
}

Widget buildBubble1(String avatar) {
  return bubbleType1();
}

Widget buildBubble2(String avatar) {
  return bubbleType2();
}

Widget buildBubble3(String avatar) {
  return bubbleType3();
}

Widget buildBubble4(String avatar) {
  return SizedBox(
    width: 60,
    height: 60,
    child: AvatarView(
      radius: 60,
      borderColor: Colors.grey,
      avatarType: AvatarType.RECTANGLE,
      backgroundColor: Colors.red,
      imagePath: avatar,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    ),
  );
}

Widget buildBubble5(String avatar) {
  return SizedBox(
    width: 60,
    height: 60,
    child: AvatarView(
      radius: 30,
      borderWidth: 8,
      borderColor: Colors.grey,
      avatarType: AvatarType.RECTANGLE,
      backgroundColor: Colors.red,
      imagePath: avatar,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    ),
  );
}
