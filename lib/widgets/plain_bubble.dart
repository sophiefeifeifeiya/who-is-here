// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/utils/Touchable.dart';
import 'package:whoshere/utils/image_uri_util.dart';
import 'package:whoshere/widgets/bubble_style/style1.dart';
import 'package:whoshere/widgets/bubble_style/style2.dart';
import 'package:whoshere/widgets/bubble_style/style3.dart';

// TODO: add bubble style Enum
// Enum BubbleStyle {
// }

class PlainBubble extends StatelessWidget {
  late String avatarUrl;
  final int style;
  final VoidCallback? cb;
  final double paddingValue;
  final double? size;

  PlainBubble({
    Key? key,
    required String avatarPath,
    this.style = 1,
    this.cb,
    this.paddingValue = 0,
    this.size,
  }) : super(key: key) {
    avatarUrl = getAvatarImageUri(avatarPath).toString();
  }

  @override
  Widget build(BuildContext context) {
    Widget bubble = Text('unexpected value');
    double _size = size ?? 80;
    switch (style) {
      case 1:
        if (cb != null) {
          bubble = makeTouchable(buildBubble1(avatarUrl), cb as VoidCallback);
        } else {
          bubble = buildBubble1(avatarUrl);
        }
        break;
      case 2:
        if (cb != null) {
          bubble = makeTouchable(
              buildBubble2(avatarUrl, size: _size), cb as VoidCallback);
        } else {
          bubble = buildBubble2(avatarUrl, size: _size);
        }
        break;
      case 3:
        if (cb != null) {
          bubble = makeTouchable(
              buildBubble3(avatarUrl, size: _size), cb as VoidCallback);
        } else {
          bubble = buildBubble3(avatarUrl, size: _size);
        }
        break;
      default:
        bubble = Text('unexpected value');
    }
    return Padding(padding: EdgeInsets.all(paddingValue), child: bubble);
  }
}

Widget buildBubble1(String avatar) {
  return BubbleType1(
    avatarUrl: avatar,
  );
}

Widget buildBubble2(String avatar, {double size = 80}) {
  return BubbleType2(
    avatarUrl: avatar,
    size: size,
  );
}

Widget buildBubble3(String avatar, {double size = 80}) {
  return BubbleType3(
    avatarUrl: avatar,
    size: size,
  );
}

Widget buildBubble4(String avatar) {
  return SizedBox(
    width: 60,
    height: 60,
    child: AvatarView(
      radius: 60,
      borderColor: Colors.grey,
      avatarType: AvatarType.RECTANGLE,
      backgroundColor: Colors.red,
      imagePath: avatar,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    ),
  );
}

Widget buildBubble5(String avatar) {
  return SizedBox(
    width: 60,
    height: 60,
    child: AvatarView(
      radius: 30,
      borderWidth: 8,
      borderColor: Colors.grey,
      avatarType: AvatarType.RECTANGLE,
      backgroundColor: Colors.red,
      imagePath: avatar,
      placeHolder: Container(
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      errorWidget: Container(
        child: Icon(
          Icons.error,
          size: 50,
        ),
      ),
    ),
  );
}
