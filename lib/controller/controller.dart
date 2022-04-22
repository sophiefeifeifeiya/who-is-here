import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/model/bubble_info.dart';

StreamController<Color> colorStreamController = StreamController.broadcast();
StreamController<int> childPageStreamController = StreamController.broadcast();
StreamController<Color> color2StreamController = StreamController.broadcast();
StreamController<BubbleStyleInfo> typeChoosingController =
    StreamController.broadcast();
StreamController<String> emojiChoosingController = StreamController.broadcast();
StreamController<BubbleStyleInfo> styleChangeController =
    StreamController.broadcast();
