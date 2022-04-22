import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:whoshere/page/bubble_setting_page.dart';
// import 'package:whoshere/stranger/page/stranger_page.dart';
// import 'package:whoshere/friend/page/friend_page.dart';
import 'package:whoshere/page/emoji_page2.dart';

// void openFriendPage(BuildContext context) {
//   CupertinoScaffold.showCupertinoModalBottomSheet(
//       context: context,
//       builder: (context) => friendPage(),
//       enableDrag: true,
//       expand: true,
//       backgroundColor: Colors.grey);
// }

// void openStrangerPage(BuildContext context) {
//   CupertinoScaffold.showCupertinoModalBottomSheet(
//       context: context,
//       builder: (context) => strangerPage(),
//       enableDrag: true,
//       expand: true,
//       backgroundColor: Colors.grey);
// }

void openBubbleSertting(BuildContext context,
    {required int bubbleStyle, String emoji = '', required String tag}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    context: context,
    builder: (context) =>
        BubbleSettingPage(bubbleStye: bubbleStyle, emoji: emoji, tag: tag),
    isScrollControlled: false,
    enableDrag: true,
  );
}
