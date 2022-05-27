import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';

import '../model/user.dart';

class AvatarWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final User? user;
  // final ValueChanged<String>? onChanged;

  final ApiBroker _broker = Get.find();

  AvatarWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
    this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    // final image = NetworkImage(_broker.getAvatarImageUri(imagePath).toString());

    print('https://whoshere.fuiyoo.tech/User/Avatar?userId=${user!.userId}');
    return ClipOval(
      child: Material(
        color: Colors.grey,
        child:imagePath.isNotEmpty ?  Ink.image(
          image: FileImage(File(imagePath)),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ): Image.network('https://whoshere.fuiyoo.tech/User/Avatar?userId=${user!.userId}'),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.blue,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
