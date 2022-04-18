// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:whoshere/page/emoji_page.dart';
import 'package:whoshere/page/style_page.dart';
import 'package:whoshere/page/color_page.dart';
import 'package:whoshere/widgets/preview.dart';
import 'package:whoshere/controller/controller.dart';
import 'package:whoshere/widgets/category.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: childPageStreamController.stream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Column(
            // scrollDirection: Axis.vertical,
            children: <Widget>[
              tapBar(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Preview(),
              ),
              SizedBox(
                height: 20,
              ),
              Categories(),
              Divider(
                height: 0.0,
                color: Colors.grey[800],
              ),
              SizedBox(
                height: 5,
              ),
              if (snapshot.data == 0) colorWidget(),
              if (snapshot.data == 1) styleWidget(),
              if (snapshot.data == 2) emojiWidget(),
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
                showDialog<Null>(
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