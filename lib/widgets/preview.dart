import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/widgets/Bubble.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  _previewState createState() => _previewState();
}

class _previewState extends State<Preview> {
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
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> type) {
                  if (type.data != null) {
                    return Bubble(style: type.data as int);
                  } else {
                    return const Bubble(style: 1);
                  }
                },
              )),
        ),
        Positioned(
          left: 110,
          child: StreamBuilder(
            stream: emojiChoosingController.stream,
            initialData: '',
            builder: (BuildContext context, AsyncSnapshot<String> emoji) {
              return Text(
                emoji.data.toString(),
                style: const TextStyle(
                  fontSize: 30.0,
                ),
              );
            },
          ),
          top: 105,
          right: 10,
        ),
      ],
    );

    return stack;
  }
}
