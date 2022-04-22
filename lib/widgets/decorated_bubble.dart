import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/model/bubble_info.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/widgets/bubble.dart';
import 'package:whoshere/utils/navigating.dart';

class DecoratedBubble extends StatefulWidget {
  final int bubbleStyle;
  final String emoji;
  final VoidCallback? onTap;
  final String tag;
  const DecoratedBubble({
    Key? key,
    required this.bubbleStyle,
    required this.tag,
    this.emoji = '',
    this.onTap,
  }) : super(key: key);

  @override
  _DecoratedBubbleState createState() => _DecoratedBubbleState();
}

class _DecoratedBubbleState extends State<DecoratedBubble> {
  int? currentStyle;
  String? currentEmoji;

  @override
  Widget build(BuildContext context) {
    var stack = Stack(
      alignment: const FractionalOffset(0.3, 0.75),
      children: [
        Positioned(
          child: SizedBox(
              height: 150,
              width: 145,
              child: StreamBuilder(
                stream: typeChoosingController.stream,
                initialData: BubbleStyleInfo(
                    bubbleStyle: widget.bubbleStyle, tag: widget.tag),
                builder: (BuildContext context,
                    AsyncSnapshot<BubbleStyleInfo> type) {
                  if (type.data?.tag == widget.tag &&
                      type.data?.bubbleStyle != null) {
                    currentStyle = type.data?.bubbleStyle as int;
                    return Bubble(style: type.data?.bubbleStyle as int);
                  } else {
                    return Bubble(style: currentStyle as int);
                  }
                },
              )),
        ),
        Positioned(
          left: currentStyle == 1 ? 90 : 110,
          top: currentStyle == 1 ? 90 : 105,
          right: 10,
          child: StreamBuilder(
            stream: emojiChoosingController.stream,
            initialData: widget.emoji,
            builder: (BuildContext context, AsyncSnapshot<String> emoji) {
              currentEmoji = emoji.data;
              return Text(
                emoji.data.toString(),
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              );
            },
          ),
        ),
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
  }
}
