// ignore_for_file: file_names
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

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
        return Container(
          width: double.infinity,
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
        break;
      case 2:
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
      default:
        return Container();
    }
  }
}
