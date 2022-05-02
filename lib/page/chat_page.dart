import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/model/chat_message.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/themes.dart';

import '../controller/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final UserStateController userStateController = Get.find();
  final ApiBroker _broker = Get.find();
  late ChatStateController chatStateController;

  ChatPage({Key? key}) : super(key: key) {
    var u = Get.arguments["user"];
    if (u == null || u is! User) {
      throw StateError(
          "Chat page requires user argument. key: user; type: User");
    }

    User user = u;
    chatStateController = Get.find(tag: user.userId);
    assert(userStateController.currentUser.value != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(chatStateController.user.value.userName)),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_chatListView(), _buttonEditBox()]));
  }

  Widget _chatListView() {
    return Expanded(
        child: Obx(() => ListView.builder(
            itemCount: chatStateController.messageList.length,
            controller: chatStateController.scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ChatMessage message = chatStateController.messageList[index];
              if (message.direction == ChatMessageDirection.receive) {
                return _fromMessageBox(message);
              } else {
                return _toMessageBox(message);
              }
            })));
  }

  Widget _buildMessageContent(ChatMessage message) {
    switch (message.contentType) {
      case ChatMessageBodyType.txt:
        return Text(
          message.content,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        );
      case ChatMessageBodyType.image:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ChatMessageBodyType.voice:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// Build the receiving message box  (on the left)
  Widget _fromMessageBox(ChatMessage chatMessage) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 5, right: 100, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(top: 5),
            child: AvatarView(
                imagePath: _broker
                    .getAvatarImageUri(
                        chatStateController.user.value.avatarPath)
                    .toString()),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChatBoxTime(chatMessage.time),
                const SizedBox(height: 2,),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: _buildMessageContent(chatMessage),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///Build the sending message box (on the right)
  Widget _toMessageBox(ChatMessage chatMessage) {
    return Container(
      margin: const EdgeInsets.only(left: 100, top: 5, right: 15, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChatBoxTime(chatMessage.time),
                const SizedBox(height: 2,),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: _buildMessageContent(chatMessage),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 40,
            width: 40,
            child: Obx(() => AvatarView(
                  imagePath: _broker
                      .getAvatarImageUri(
                          userStateController.currentUser.value!.avatarPath)
                      .toString(),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBoxTime(DateTime time) {
    DateTime localTime = time.toLocal();
    return Text(
      "${localTime.hour}:${localTime.minute.toString().padLeft(2, "0")}",
      style: const TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  Widget _buttonEditBox() {
    return Container(
      color: Colors.black12,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: TextField(
                maxLines: 1,
                controller: chatStateController.textEditController,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '',
                  hintStyle:
                      TextStyle(fontSize: 14.0, color: Color(0xffc1c1c1)),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: chatStateController.sendMessage,
              icon: const Icon(
                Icons.send,
                color: MyThemes.primary,
              ))
        ],
      ),
    );
  }
}
