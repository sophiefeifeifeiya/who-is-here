import 'package:flutter/cupertino.dart';

class BubbleStyleInfo extends Object {
  final int bubbleStyle;
  final String tag;

  const BubbleStyleInfo({
    required this.bubbleStyle,
    required this.tag,
  });
}

class BubbleEmojiInfo {
  final String emoji;
  final String tag;

  const BubbleEmojiInfo({
    required this.emoji,
    required this.tag,
  });
}

class BubbleColorInfo {
  final Color color;
  final String tag;

  const BubbleColorInfo({
    required this.color,
    required this.tag,
  });
}
