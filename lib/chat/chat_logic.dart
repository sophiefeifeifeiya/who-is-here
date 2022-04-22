import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/model/message.dart';

import 'chat_state.dart';

class ChatLogic extends GetxController {
  ChatState state = ChatState();

  void initMessageList() {
    state.messageList.clear();
    //构造数据
    for (int i = 0; i < 18; i++) {
      EMMessage message = EMMessage();
      if (i > 12) {
        if (i % 2 == 0) {
          message.direction = EMMessageDirection.RECIEVE;
          if (i == 14 || i == 16) {
            message.msgType = EMMessageBodyType.VOICE;
          } else {
            message.msgType = EMMessageBodyType.IMAGE;
            message.content =
                "https://image.baidu.com/search/wisemiddetail?tn=wisemiddetail&ie=utf8&word=%E5%AB%A9%E8%90%9D%E8%8E%89&fmpage=detail&pn=1&size=&pos=img";
          }
        } else {
          message.direction = EMMessageDirection.SEND;
          message.msgType = EMMessageBodyType.VOICE;
          if (i == 13 || i == 15) {
            message.msgType = EMMessageBodyType.VOICE;
          } else {
            message.msgType = EMMessageBodyType.IMAGE;
            message.content =
                "https://img1.baidu.com/it/u=3513881589,1975851601&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1082";
          }
        }
      } else {
        message.msgType = EMMessageBodyType.TXT;
        if (i % 2 == 0) {
          message.direction = EMMessageDirection.RECIEVE;
          message.content = "对方发送的消息" + i.toString();
        } else {
          message.direction = EMMessageDirection.SEND;
          message.content = "我发送给对方的消息" + i.toString();
        }
      }
      state.messageList.add(message);
    }
    update();
  }

  void appendMessage(EMMessage emMessage) {
    state.messageList.add(emMessage);
    update();
  }

  void showSend(bool show) {
    state.showSend = show;
    update();
  }
}
