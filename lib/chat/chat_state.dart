import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:whoshere/model/message.dart';

class ChatState {
  ChatState();
  TextEditingController pswController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool showSend = false;
  List<EMMessage> messageList = [];
}
