import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/widgets/bubble.dart';

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
                initialData: widget.bubbleStyle,
                builder: (BuildContext context, AsyncSnapshot<int> type) {
                  if (type.data != null) {
                    return Bubble(style: type.data as int);
                  } else {
                    return const Bubble(style: 2);
                  }
                },
              )),
        ),
        Positioned(
          left: widget.bubbleStyle == 1 ? 90 : 110,
          top: widget.bubbleStyle == 1 ? 90 : 105,
          right: 10,
          child: StreamBuilder(
            stream: emojiChoosingController.stream,
            initialData: widget.emoji,
            builder: (BuildContext context, AsyncSnapshot<String> emoji) {
              print('emoji');
              print(emoji.data);
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

    if (widget.onTap != null) {
      return makeTouchable(stack, widget.onTap as VoidCallback);
    } else {
      return stack;
    }
  }
}
