import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/model/bubble_info.dart';

class emojiWidget extends StatelessWidget {
  final String tag;

  const emojiWidget({Key? key, required this.tag}) : super(key: key);

  _onEmojiSelected(Emoji emoji) {
    emojiChoosingController.add(BubbleEmojiInfo(emoji: emoji.emoji, tag: tag));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: EmojiPicker(
          onEmojiSelected: (category, Emoji emoji) {
            _onEmojiSelected(emoji);
          },
          // onBackspacePressed: _onBackspacePressed,
          config: const Config(
              columns: 7,
              emojiSizeMax: 32,
              verticalSpacing: 0,
              horizontalSpacing: 0,
              // initCategory: Category.RECENT,
              bgColor: Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              showRecentsTab: false,
              recentsLimit: 28,
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL)),
    );
  }
// }
}
