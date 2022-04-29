import 'package:get/get.dart';

enum ChatMessageBodyType {
  txt,
  image, // not supported yet
  voice, // not supported yet
}
enum ChatMessageDirection {
  receive,
  send,
}

class ChatMessage {
  final ChatMessageDirection direction;
  final String content;
  final ChatMessageBodyType contentType;
  final DateTime time;
  final RxBool sending = false.obs;
  final RxBool sendFailed = false.obs;

  ChatMessage(
      {required this.direction,
      required this.content,
      required this.contentType,
      required this.time,
      bool? sending}) {
    if (sending != null) {
      this.sending.value = sending;
    }
  }
}
