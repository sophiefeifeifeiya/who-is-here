import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/model/bubble_info.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/widgets/plain_bubble.dart';
import 'package:whoshere/utils/navigating.dart';
import 'package:whoshere/widgets/emoji_decrorator.dart';

class DecoratedBubble extends StatefulWidget {
  final int bubbleStyle;
  final String emoji;
  final VoidCallback? onTap;
  final String tag;
  final double width;
  final double height;
  final bool onMap;

  const DecoratedBubble(
      {Key? key,
      required this.bubbleStyle,
      required this.tag,
      this.emoji = '',
      this.onTap,
      this.width = 150,
      this.height = 145,
      this.onMap = false})
      : super(key: key);

  @override
  _DecoratedBubbleState createState() => _DecoratedBubbleState();
}

class _DecoratedBubbleState extends State<DecoratedBubble> {
  int? currentStyle;
  String? currentEmoji;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: typeChoosingController.stream,
      initialData:
          BubbleStyleInfo(bubbleStyle: widget.bubbleStyle, tag: widget.tag),
      builder: (BuildContext context, AsyncSnapshot<BubbleStyleInfo> type) {
        Widget bubble;
        if (type.data?.tag == widget.tag && type.data?.bubbleStyle != null) {
          currentStyle = type.data?.bubbleStyle as int;
        }
        bubble = PlainBubble(style: currentStyle as int);
        var stack = Stack(
          alignment: const FractionalOffset(0.3, 0.75),
          children: [
            Positioned(
              child: SizedBox(
                  height:
                      (widget.onMap && currentStyle != 1) ? 85 : widget.height,
                  width:
                      (widget.onMap && currentStyle != 1) ? 85 : widget.height,
                  child: bubble),
            ),
            EmojiDecroator(
              tag: widget.tag,
              right: currentStyle == 1 ? 20 : 0,
              bottom: currentStyle == 1 ? 20 : 0,
              emoji: widget.emoji,
            )
          ],
        );
        if (widget.onTap == null) {
          return stack;
        } else if (currentStyle == widget.bubbleStyle) {
          return makeTouchable(stack, widget.onTap as VoidCallback);
        } else {
          return makeTouchable(
              stack,
              () => openBubbleSertting(context,
                  bubbleStyle: currentStyle ?? widget.bubbleStyle,
                  emoji: currentEmoji ?? widget.emoji,
                  tag: widget.tag));
        }
      },
    );
  }
}
