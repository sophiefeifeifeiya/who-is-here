import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';

class BubbleType3 extends StatelessWidget {
  final String avatarUrl;
  final double size;

  const BubbleType3({Key? key, required this.avatarUrl, this.size = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
          child: AvatarView(
        radius: 40,
        borderWidth: 10,
        borderColor: Colors.lightBlue,
        avatarType: AvatarType.RECTANGLE,
        backgroundColor: Colors.red,
        imagePath: avatarUrl,
        placeHolder: Icon(
          Icons.person,
          size: size,
        ),
        errorWidget: Icon(
          Icons.error,
          size: size,
        ),
      )),
    );
  }
}
