import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:whoshere/stranger/page/stranger_page.dart';
import 'package:whoshere/friend/page/friend_page.dart';

void openFriendPage(BuildContext context) {
  CupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => friendPage(),
      enableDrag: true,
      expand: true,
      backgroundColor: Colors.grey);
}

void openStrangerPage(BuildContext context) {
  CupertinoScaffold.showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => strangerPage(),
      enableDrag: true,
      expand: true,
      backgroundColor: Colors.grey);
}
