// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

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
        return buildBubble1(avatar);
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
  return Container(
    width: 50,
    height: 50,
    color: Colors.white,
    child: AvatarGlow(
      startDelay: Duration(milliseconds: 1000),
      glowColor: Colors.blue,
      //边框大小
      endRadius: 120.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        child: CircleAvatar(
          //picture
          backgroundImage: AssetImage(avatar),
          radius: 70.0,
        ),
      ),
      shape: BoxShape.circle,
      animate: true,
      curve: Curves.fastOutSlowIn,
    ),
  );
}

Widget buildBubble2(String avatar) {
  return AvatarView(
    radius: 60,
    borderColor: Colors.yellow,
    isOnlyText: false,
    text: Text(
      'C',
      style: TextStyle(color: Colors.white, fontSize: 50),
    ),
    avatarType: AvatarType.CIRCLE,
    backgroundColor: Colors.red,
    imagePath: avatar,
    placeHolder: Container(
      child: Icon(
        Icons.person,
        size: 25,
      ),
    ),
    errorWidget: Container(
      child: Icon(
        Icons.error,
        size: 25,
      ),
    ),
  );
}

Widget buildBubble3(String avatar) {
  return AvatarView(
    radius: 60,
    borderWidth: 8,
    borderColor: Colors.yellow,
    avatarType: AvatarType.CIRCLE,
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
  );
}

Widget buildBubble4(String avatar) {
  return AvatarView(
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
  );
}

Widget buildBubble5(String avatar) {
  return AvatarView(
    radius: 60,
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
  );
}
