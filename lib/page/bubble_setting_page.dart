// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/page/emoji_page.dart';
import 'package:whoshere/page/style_page.dart';
import 'package:whoshere/page/color_page.dart';
import 'package:whoshere/widgets/decorated_bubble.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/widgets/category.dart';

class BubbleSettingPage extends StatelessWidget {
  final int bubbleStye;
  final String tag;
  final String emoji;

  final UserStateController stateController = Get.find();

  static final Map<int, Widget?> panelMap = {
    0: null,
    1: null,
    2: null,
  };

  BubbleSettingPage(
      {Key? key, required this.bubbleStye, this.emoji = '', required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: childPageStreamController.stream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          Widget panel;
          int panelType = snapshot.data ?? 0;
          if (panelMap[panelType] == null) {
            if (panelType == 0) {
              panelMap[panelType] = colorWidget(tag: tag);
            } else if (panelType == 1) {
              panelMap[panelType] = Obx(() => StyleWidget(
                    tag: tag,
                    avatarPath: stateController.currentUser.value!.avatarPath,
                  ));
            } else if (panelType == 2) {
              panelMap[panelType] = emojiWidget(
                tag: tag,
              );
            } else {
              panelMap[panelType] = Text('unexpected value');
            }
          }
          panel = panelMap[panelType]!;
          return Column(
            // scrollDirection: Axis.vertical,
            children: <Widget>[
              tapBar(),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Obx(() => DecoratedBubble(
                      width: 120,
                      height: 120,
                      tag: tag,
                      bubbleStyle: bubbleStye,
                      emoji: emoji,
                      avatarPath: stateController.currentUser.value!.avatarPath,
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Categories(),
              Divider(
                height: 0.0,
                color: Colors.grey[800],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(child: panel)
            ],
          );
        });
  }
}

class tapBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              child: const Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.black, fontSize: 17.0, height: 1.0),
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: AlertDialog(
                        title: Text("Warning"),
                        content: Text("Want to save your bubble setting?"),
                        actions: <Widget>[
                          TextButton(
                              child: Text("Save"),
                              onPressed: () => {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst)
                                  }),
                          SizedBox(
                            width: 125,
                          ),
                          TextButton(
                              child: Text("Don't save"),
                              onPressed: () => {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst)
                                  }),
                        ],
                      ),
                    );
                  },
                );
              }),
          TextButton(
            child: Text(
              'Done',
              style:
                  TextStyle(color: Colors.black, fontSize: 17.0, height: 1.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    );
  }
}
