// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

Widget makeTouchable(Widget w, VoidCallback calllBack) {
// The GestureDetector wraps the button.
  return GestureDetector(
    // When the child is tapped, show a snackbar.
    onTap: calllBack,
    // The custom button
    child: w,
  );
}
