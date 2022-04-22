// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

Widget makeTouchable(Widget w, VoidCallback calllBack) {
  // return GestureDetector(
  //   onTap: calllBack,
  //   child: w,
  // );

  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: calllBack,
    child: AbsorbPointer(
      child: w,
    ),
  );
}
