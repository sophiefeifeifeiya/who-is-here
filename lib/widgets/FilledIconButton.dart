// ignore_for_file: file_names
import 'package:flutter/material.dart';

class FilledIconButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color color;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  const FilledIconButton(
      {Key? key,
      this.icon = Icons.person,
      this.color = Colors.white,
      this.background = Colors.lightBlue,
      this.width = 50,
      this.height = 50,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        // TODO: add hovered color
        style: TextButton.styleFrom(
          backgroundColor: background,
          shape: const CircleBorder(),
        ),
        child: Icon(
          icon,
          size: width - 15,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
