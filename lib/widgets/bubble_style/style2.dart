// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';

class BubbleType2 extends StatelessWidget {
  final String avatarUrl;
  final double size;

  const BubbleType2({Key? key, required this.avatarUrl, this.size = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('===== size =====');
    print(size);
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        child: AvatarView(
            radius: 1000,
            borderWidth: 10,
            borderColor: Colors.lightBlue,
            avatarType: AvatarType.CIRCLE,
            backgroundColor: Colors.red,
            imagePath: avatarUrl,
            placeHolder: const Icon(
              Icons.person,
              size: 50,
            )),
      ),
    );
  }
}
