import 'package:flutter/material.dart';
import 'package:whoshere/widgets/color_picker.dart';

import '../widgets/color_button.dart';

class colorWidget extends StatelessWidget {
  final String tag;
  const colorWidget({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 6,
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            ColorButton((Colors.red)),
            ColorButton((Colors.orange)),
            ColorButton((Colors.yellow)),
            ColorButton((Colors.green)),
            ColorButton((Colors.blue)),
            ColorButton((Colors.purple)),
            ColorButton(Colors.pink),
            ColorButton(Colors.cyan),
            ColorButton(Colors.teal),
            ColorButton(Colors.grey),
            ColorButton(Colors.black),
          ],
        ),
        Positioned(bottom: 10, child: Center(child: ColorPicker(350)))
      ],
    );
  }
}
