// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

Widget makeTouchable(Widget w, VoidCallback calllBack) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: calllBack,
    child: AbsorbPointer(
      // if it is the child of GestureDetector which is one of children of
      // a Stack，it shold be wrapped by AbsorbPointer
      child: w,
    ),
  );
}
