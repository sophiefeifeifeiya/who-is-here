import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/utils/navigating.dart';

class BubbleType1 extends StatelessWidget {
  final int scene;
  final String avatarUrl;

  const BubbleType1({Key? key, required this.avatarUrl, this.scene = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AvatarGlow(
        startDelay: const Duration(milliseconds: 0),
        glowColor: Colors.blue,
        //边框大小
        endRadius: 80.0,
        duration: const Duration(milliseconds: 1000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: const Duration(milliseconds: 0),
        child: Material(
          elevation: 8.0,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: CircleAvatar(
            //picture
            backgroundImage: NetworkImage(avatarUrl),
            radius: 40.0,
          ),
        ),
        shape: BoxShape.circle,
        animate: true,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}
