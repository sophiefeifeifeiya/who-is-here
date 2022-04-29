import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/model/chat_message.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/routes/route_pages.dart';

class ChatStateController extends GetxController {
  final TextEditingController textEditController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<ChatMessage> messageList = <ChatMessage>[].obs;
  final Rx<User> user;
  final ApiBroker _broker = Get.find();

  WebSocketChannel? _chatChannel;

  ChatStateController({required this.user});

  @override
  void onInit() async {
    try {
      _chatChannel = await _broker.openChatChannel();
      _chatChannel!.stream.listen(onMessageReceived);
    } on ApiBrokerException catch (e) {
      await Get.dialog(AlertDialog(
        title: const Text("We have a problem..."),
        content: Text(e.errorMessage),
      ));
      Get.offNamed(RoutePages.chat);
    }
  }

  void onMessageReceived(dynamic event) {
    if (event is Map<String, dynamic>) {
      messageList.add(ChatMessage(
          direction: ChatMessageDirection.receive,
          content: event["Message"],
          contentType: ChatMessageBodyType.txt,
          time: DateTime.parse(event["SendTime"])));
    }
    print(event);
  }

  RxBool showSend = false.obs;

  void initMessageList() {}

  void saveMessageList() {}

  void sendMessage() {
    var chatMessage = ChatMessage(
      direction: ChatMessageDirection.send,
      content: textEditController.text,
      contentType: ChatMessageBodyType.txt,
      time: DateTime.now(),
      sending: true,
    );

    _sendMessageToChannel(chatMessage);
    messageList.add(chatMessage);
  }

  void _sendMessageToChannel(ChatMessage chatMessage) async {
    if (_chatChannel == null) {
      chatMessage.sending.value = false;
      chatMessage.sendFailed.value = true;
      return;
    } else {
      _chatChannel!.sink.add(json.encode(
          {"receiverId": user.value.userId, "message": chatMessage.content}));

      chatMessage.sending.value = false; // TODO: wait for sending
    }
  }
}
