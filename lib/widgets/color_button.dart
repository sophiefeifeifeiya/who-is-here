import 'package:flutter/material.dart';

import '../controller/controller.dart';

class ColorButton extends StatelessWidget {
  Color color;
  ColorButton(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: FloatingActionButton(
        backgroundColor: color,
        onPressed: () {
          colorStreamController.add(color);
          color2StreamController.add(color);
        },
        mini: true,
      ),
    );
  }
}
