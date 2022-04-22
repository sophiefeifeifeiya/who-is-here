import 'package:flutter/material.dart';
import 'package:whoshere/page/friend_page.dart';
import 'package:whoshere/widgets/emojis.dart';

class tapBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          alignment: Alignment.topCenter,
          // width: 300,
          child: hello_bar(),
        ),
        Positioned(
          top: 30,
          left: 1,
          right: 1,
          child: Container(
            height: 400,
            width: 430,
            child: gridView(),
          ),
        ),
      ],
    );
  }
}
