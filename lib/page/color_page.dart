import 'package:flutter/material.dart';
import 'package:whoshere/widgets/color_picker.dart';

import '../widgets/color_button.dart';

class colorWidget extends StatelessWidget {
  final String tag;
  const colorWidget({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 10.0),
            ColorButton((Colors.red)),
            const SizedBox(width: 5.0),
            ColorButton((Colors.orange)),
            const SizedBox(width: 5.0),
            ColorButton((Colors.yellow)),
            const SizedBox(width: 5.0),
            ColorButton((Colors.green)),
            const SizedBox(width: 5.0),
            ColorButton((Colors.blue)),
            const SizedBox(width: 5.0),
            ColorButton((Colors.purple)),
            const SizedBox(width: 5.0),
            ColorButton(Colors.pink),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 10.0),
            ColorButton(Colors.cyan),
            const SizedBox(width: 5.0),
            ColorButton(Colors.teal),
            const SizedBox(width: 5.0),
            ColorButton(Colors.grey),
            const SizedBox(width: 5.0),
            ColorButton(Colors.black),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Center(child: ColorPicker(350))
      ],
    );
  }
}
