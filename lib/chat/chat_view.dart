import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/model/message.dart';
import 'package:whoshere/utils/size_config.dart';

import 'chat_logic.dart';

class ChatPage extends StatelessWidget {
  final logic = Get.put(ChatLogic());
  final state = Get.find<ChatLogic>().state;

  ChatPage({Key? key}) : super(key: key) {
    logic.initMessageList();
    _toBottom();
  }

  _toBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      state.scrollController
          .jumpTo(state.scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("与用户1聊天"),
          centerTitle: true,
        ),
        body: GetBuilder<ChatLogic>(
          builder: (logic) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_chatListView(), _buttonEditBox()],
            );
          },
        ));
  }

  Widget _chatListView() {
    return Expanded(
        child: ListView.builder(
            itemCount: state.messageList.length,
            controller: state.scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              EMMessage message = state.messageList[index];
              if (message.direction == EMMessageDirection.RECIEVE) {
                return _fromTextItem(message);
              } else {
                return _toTextItem(message);
              }
            }));
  }

  ///左
  Widget _fromTextItem(EMMessage emMessage) {
    return Container(
      margin:
          EdgeInsets.only(left: 15.px, top: 5.px, right: 100.px, bottom: 10.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.px),
            child: Icon(
              Icons.account_circle,
              color: Colors.blueAccent,
              size: 35.px,
            ),
          ),
          SizedBox(
            width: 2.px,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "用户1",
                  style: TextStyle(fontSize: 14.px),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.px, vertical: 5.px),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    //设置四周圆角
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: emMessage.msgType == EMMessageBodyType.TXT
                      ? Text(
                          '${emMessage.content}',
                          style:
                              TextStyle(fontSize: 16.px, color: Colors.white),
                        )
                      : emMessage.msgType == EMMessageBodyType.VOICE
                          ? Image.asset(
                              "assets/images/chat_voice.png",
                              width: 25.px,
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: "assets/images/chat_voice.png",
                              image: '${emMessage.content}'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///右
  Widget _toTextItem(EMMessage emMessage) {
    return Container(
      margin:
          EdgeInsets.only(left: 100.px, top: 5.px, right: 15.px, bottom: 10.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "用户2",
                  style: TextStyle(fontSize: 14.px),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.px, vertical: 5.px),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    //设置四周圆角
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: emMessage.msgType == EMMessageBodyType.TXT
                      ? Text(
                          '${emMessage.content}',
                          style:
                              TextStyle(fontSize: 16.px, color: Colors.white),
                        )
                      : emMessage.msgType == EMMessageBodyType.VOICE
                          ? Transform.rotate(
                              angle: 135,
                              child: Image.asset(
                                "assets/images/chat_voice.png",
                                width: 25.px,
                              ),
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: "", image: '${emMessage.content}'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 2.px,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.px),
            child: Icon(
              Icons.account_circle,
              color: Colors.redAccent,
              size: 35.px,
            ),
          ),
        ],
      ),
    );
  }

  ///编辑框
  Widget _buttonEditBox() {
    return Container(
      color: Colors.black12,
      child: Row(
        children: [
          SizedBox(
            width: 15.px,
          ),
          Image.asset(
            "assets/images/voice.png",
            width: 25.px,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
              decoration: const BoxDecoration(
                color: Colors.white54,
                //设置四周圆角
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                maxLines: 1,
                // obscureText: true,
                controller: state.pswController,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14.px),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.px, 0, 10.px, 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '',
                  hintStyle:
                      const TextStyle(fontSize: 14.0, color: Color(0xffc1c1c1)),
                ),
              ),
            ),
          ),
          TextButton(
            child: const Text("发送"),
            onPressed: () {
              EMMessage message = EMMessage();
              message.msgType = EMMessageBodyType.TXT;
              message.direction = EMMessageDirection.SEND;
              message.content = state.pswController.text;
              logic.appendMessage(message);
              _toBottom();
              state.pswController.text = "";
            },
          )
          /* Row(
                  children: [
                    Image.asset(
                      "assets/images/xiaolian.png",
                      width: 25.px,
                    ),
                    SizedBox(
                      width: 10.px,
                    ),
                    Image.asset(
                      "assets/images/add.png",
                      width: 25.px,
                    ),
                    SizedBox(
                      width: 15.px,
                    ),
                  ],
                )*/
        ],
      ),
    );
  }
}
