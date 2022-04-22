// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:whoshere/widgets/plain_bubble.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/model/bubble_info.dart';

void swicthStyle(int style, String tag) {
  typeChoosingController.add(BubbleStyleInfo(bubbleStyle: style, tag: tag));
}

class styleWidget extends StatelessWidget {
  final String tag;
  const styleWidget({Key? key, required this.tag}) : super(key: key);

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
              PlainBubble(
                style: 1,
                cb: () => swicthStyle(1, tag),
              ),
              // bubbleType1(),
              PlainBubble(
                style: 2,
                cb: () => swicthStyle(2, tag),
              ),
              PlainBubble(
                style: 3,
                cb: () => swicthStyle(3, tag),
              ),
            ]));
  }
}
