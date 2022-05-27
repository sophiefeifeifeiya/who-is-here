import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:whoshere/model/chat_message.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/service/services.dart';

class ChatStateController extends GetxController {
  final TextEditingController textEditController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final IUserChatService chatService = Get.find();

  final RxList<ChatMessage> messageList = <ChatMessage>[].obs;
  final Rx<User> user;

  StreamSubscription? chatSubscription;

  ChatStateController({required this.user});

  void onMessageReceived(ChatNotification chatNotification) {
    messageList.add(chatNotification.message);
    chatService.saveMessage(user.value.userId, chatNotification.message);
    FlutterRingtonePlayer.playNotification();
  }

  @override
  void onInit() async {
    super.onInit();
    chatSubscription = chatService.onMessageReceived
        .where((event) => event.senderId == user.value.userId)
        .listen(onMessageReceived);
    var messages = await chatService.loadChatHistory(user.value.userId);
    messageList.addAll(messages);
    scrollToBottom();
  }

  @override
  void onClose() {
    chatSubscription?.cancel();
  }

  RxBool showSend = false.obs;

  void sendMessage() {
    var chatMessage = ChatMessage(
      direction: ChatMessageDirection.send,
      content: textEditController.text,
      contentType: ChatMessageBodyType.txt,
      time: DateTime.now(),
      sending: true,
    );
    textEditController.clear();
    _sendMessageToChannelAndSave(chatMessage);
    scrollToBottom();
  }

  void _sendMessageToChannelAndSave(ChatMessage chatMessage) async {
    messageList.add(chatMessage);
    try {
      await chatService.sendMessage(user.value.userId, chatMessage);
      chatService.saveMessage(user.value.userId, chatMessage);
    } on ChatRequestException {
      chatMessage.sendFailed.value = true;
    }
    chatMessage.sending.value = false;
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}
