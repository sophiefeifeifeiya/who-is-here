import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/model/chat_message.dart';
import 'package:whoshere/service/services.dart';

class UserChatService extends IUserChatService {
  static const String db_table_name = "chat_messages";

  final ApiBroker _broker = Get.find();
  final StreamController<ChatNotification> _chatMessageController =
      StreamController<ChatNotification>();

  Completer<ChatResponse>? _completer;
  final Lock _lockWebSocket = Lock();

  final Lock _lockDbWrite = Lock();

  WebSocketChannel? _channel;
  StreamSubscription? _channelSubscription;
  Future<WebSocketChannel>? _connecting;

  @override
  void connect() {
    if (_connecting != null) {
      return;
    }

    _connecting = _broker.openChatChannel();
    _connecting!.then((value) {
      _channel = value;
      _channelSubscription = _channel!.stream.listen(
          _onWebSocketMessageReceived,
          onError: _onWebSocketError,
          onDone: _onWebSocketDone);

      _connecting = null;
    });
  }

  void _handleEvent(Map<String, dynamic> event) {
    printInfo(info: event.toString());
    if (event["\$event"] == "ChatMessage") {
      ChatEvent chatEvent = ChatEvent.fromJson(event);
      _chatMessageController.sink.add(ChatNotification(
          senderId: chatEvent.senderId,
          message: ChatMessage(
              direction: ChatMessageDirection.receive,
              content: chatEvent.message,
              contentType: ChatMessageBodyType.txt,
              time: chatEvent.sendTime)));
    } else {
      printError(info: "Unsupported message type: ${event["\$event"]}");
    }
  }

  void _onWebSocketMessageReceived(dynamic event) {
    printInfo(info: event.toString());
    Map<String, dynamic> map = json.decode(event);
    if (map.containsKey("\$statusCode")) {
      if (_completer != null) {
        _completer!.complete(ChatResponse.fromJson(map));
      }
    } else if (map.containsKey("\$event")) {
      _handleEvent(map);
    }
  }

  void _onWebSocketError(Object object, StackTrace trace) {
    printError(info: object.toString());
    printError(info: trace.toString());
  }

  void _onWebSocketDone() {
    printError(info: "WebSocket done");
    _channelSubscription!.cancel();
    Future.delayed(const Duration(seconds: 10)).then((value) => connect());
  }

  @override
  Stream<ChatNotification> get onMessageReceived =>
      _chatMessageController.stream;

  @override
  Future sendMessage(String receiverId, ChatMessage chatMessage) async {
    await _lockWebSocket.synchronized(() async {
      _completer = Completer<ChatResponse>();
      printInfo(info: "Sending message: ${chatMessage.content}");
      _channel!.sink.add(json
          .encode({"receiverId": receiverId, "message": chatMessage.content}));
      printInfo(info: "Waiting response");
      ChatResponse response = await _completer!.future;
      _completer = null;
      printInfo(info: "OK");
      if (response.statusCode != 200) {
        throw ChatRequestException(
            statusCode: response.statusCode,
            errorMessage: response.errorMessage);
      }
    });
  }

  Future _openChatHistoryDatabase(String chatPeerId) async {
    return await openDatabase(
        join(await getDatabasesPath(), "chat/$chatPeerId.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE chat_messages(id INTEGER PRIMARY KEY, content TEXT, sendDirection BOOL, contentType INTEGER, time TEXT)");
    }, version: 1);
  }

  @override
  Future<Iterable<ChatMessage>> loadChatHistory(String chatPeerId) async {
    final db = await _openChatHistoryDatabase(chatPeerId);
    final List<Map<String, dynamic>> maps = await db.query(db_table_name);
    return maps.map((e) => ChatMessage.fromJson(e));
  }

  @override
  Future saveMessage(String chatPeerId, ChatMessage chatMessage) async {
    final db = await _openChatHistoryDatabase(chatPeerId);
    await _lockDbWrite.synchronized(() async {
      await db.insert(db_table_name, chatMessage.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }
}
