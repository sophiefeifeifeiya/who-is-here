import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/page/setting_page.dart';

void openBubbleSertting(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    context: context,
    builder: (context) => SettingPage(),
    isScrollControlled: false,
    enableDrag: true,
  );
}

//
class bubbleType1 extends StatelessWidget {
  int scene;
  bubbleType1({Key? key, this.scene = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (scene == 0) {
          typeChoosingController.add(0);
        } else {
          openBubbleSertting(context);
        }
      },
      child: AvatarGlow(
        startDelay: Duration(milliseconds: 0),
        glowColor: Colors.blue,
        //边框大小
        endRadius: 80.0,
        duration: Duration(milliseconds: 1000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 0),
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          color: Colors.transparent,
          child: CircleAvatar(
            //picture
            backgroundImage: NetworkImage(
                'https://img0.baidu.com/it/u=1579365749,3577175995&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=475'),
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
