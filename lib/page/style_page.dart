// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/widgets/Bubble.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/controller/controller.dart';
import '../style_resource/style1.dart';
import '../style_resource/style2.dart';
import '../style_resource/style3.dart';

void inform(index) {
  typeChoosingController.add(2);
  print('trigerred');
}

class styleWidget extends StatelessWidget {
  const styleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: EdgeInsets.all(10),
        color: Colors.transparent,
        child: GridView.count(
            crossAxisCount: 1,
            padding: const EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              // bubbleType1(),
              makeTouchable(buildBubble1('images/avatar.png'), () => inform(1)),
              bubbleType2(),
              bubbleType3(),
              bubbleType1(),
              bubbleType1(),
              bubbleType1()
            ]));
  }
}
