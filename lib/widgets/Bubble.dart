// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/widgets/bubble_style/style1.dart';
import 'package:whoshere/widgets/bubble_style/style2.dart';
import 'package:whoshere/widgets/bubble_style/style3.dart';
import 'package:whoshere/utils/navigating.dart';

// TODO: add bubble style Enum
// Enum BubbleStyle {
// }

class Bubble extends StatelessWidget {
  final String avatar;
  final int style;
  const Bubble({
    Key? key,
    required this.avatar,
    this.style = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case 1:
        // return buildBubble2(avatar);
        return makeTouchable(
            buildBubble1(avatar), () => openBubbleSertting(context));
      case 2:
        return buildBubble2(avatar);
      case 3:
        return buildBubble3(avatar);
      case 4:
        return buildBubble4(avatar);
      case 5:
        return buildBubble5(avatar);
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
