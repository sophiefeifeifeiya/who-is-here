// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:whoshere/widgets/bubble_style/style1.dart';
import 'package:whoshere/widgets/bubble_style/style2.dart';
import 'package:whoshere/widgets/bubble_style/style3.dart';

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
              bubbleType1(),
              bubbleType2(),
              bubbleType3(),
            ]));
  }
}
