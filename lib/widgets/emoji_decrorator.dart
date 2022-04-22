import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/model/bubble_info.dart';

class EmojiDecroator extends StatefulWidget {
  final String tag;
  final double right;
  final double bottom;
  final String emoji;

  const EmojiDecroator({
    Key? key,
    required this.tag,
    this.emoji = '',
    this.right = 5,
    this.bottom = 5,
  }) : super(key: key);

  @override
  _DecoratedBubbleState createState() => _DecoratedBubbleState();
}

class _DecoratedBubbleState extends State<EmojiDecroator> {
  String? currentEmoji;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: widget.right,
      bottom: widget.bottom,
      child: StreamBuilder(
        stream: emojiChoosingController.stream,
        initialData: BubbleEmojiInfo(emoji: widget.emoji, tag: widget.tag),
        builder: (BuildContext context,
            AsyncSnapshot<BubbleEmojiInfo> bubbleEmojiInfo) {
          if (bubbleEmojiInfo.data?.tag == widget.tag) {
            currentEmoji = bubbleEmojiInfo.data?.emoji;
          }
          return Text(
            currentEmoji.toString(),
            style: const TextStyle(
              fontSize: 30.0,
            ),
          );
        },
      ),
    );
  }
}
