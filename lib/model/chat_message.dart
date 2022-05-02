import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

enum ChatMessageBodyType {
  txt,
  image, // not supported yet
  voice, // not supported yet
}
enum ChatMessageDirection {
  receive,
  send,
}

/// Used in local state
class ChatNotification {
  final String senderId;
  final ChatMessage message;

  ChatNotification({required this.senderId, required this.message});
}

@JsonSerializable()
class ChatMessage {
  @JsonKey(
      name: "sendDirection",
      fromJson: _chatMessageDirectionFromJson,
      toJson: _chatMessageDirectionToJson)
  final ChatMessageDirection direction;
  final String content;
  final ChatMessageBodyType contentType;
  final DateTime time;

  @JsonKey(ignore: true)
  final RxBool sending = false.obs;
  @JsonKey(ignore: true)
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

  static ChatMessageDirection _chatMessageDirectionFromJson(dynamic json) {
    return json == 0
        ? ChatMessageDirection.receive
        : ChatMessageDirection.send;
  }

  static dynamic _chatMessageDirectionToJson(ChatMessageDirection direction) {
    if (direction == ChatMessageDirection.send) {
      return 1;
    } else {
      return 0;
    }
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

/// WebSocket Chatting Protocol event
///
/// The backend server can send event to notify the client
@JsonSerializable()
class ChatEvent {
  @JsonKey(name: "\$event")
  final String event;
  final String senderId;
  final DateTime sendTime;
  final String message;

  ChatEvent(
      {required this.event,
      required this.senderId,
      required this.sendTime,
      required this.message});

  factory ChatEvent.fromJson(Map<String, dynamic> json) =>
      _$ChatEventFromJson(json);

  Map<String, dynamic> toJson() => _$ChatEventToJson(this);
}

/// WebSocket Chatting Protocol response
///
/// After a request, the backend server will return a response message
@JsonSerializable()
class ChatResponse {
  @JsonKey(name: "\$statusCode")
  final int statusCode;
  final String? errorMessage;

  ChatResponse({required this.statusCode, this.errorMessage});

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
