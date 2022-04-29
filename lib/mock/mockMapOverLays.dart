// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:whoshere/utils/navigating.dart';

import '../widgets/MapOverlay.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:whoshere/widgets/decorated_bubble.dart';

List<MapOverlay> getMockMapOverLays(
    BuildContext context, VoidCallback _showPersistantBottomSheetCallBack) {
  return [
    // MapOverlay(
    //   coordinate: LatLng(23.477641, 111.274786),
    //   child: DecoratedBubble(
    //     bubbleStyle: 1,
    //     emoji: '😅',
    //     tag: 'current_user',
    //     onTap: () => openBubbleSertting(context,
    //         bubbleStyle: 1, emoji: '😅', tag: 'current_user'),
    //     onMap: true,
    //   ),
    // ),
    // MapOverlay(
    //     coordinate: LatLng(23.467641, 111.274786),
    //     child: DecoratedBubble(
    //       bubbleStyle: 2,
    //       emoji: '😅',
    //       tag: 'other_user_a',
    //       width: 85,
    //       height: 85,
    //       onTap: () => _showPersistantBottomSheetCallBack(),
    //       onMap: true,
    //     )),
    // MapOverlay(
    //     coordinate: LatLng(23.477641, 111.260786),
    //     child: DecoratedBubble(
    //       bubbleStyle: 3,
    //       emoji: '😅',
    //       tag: 'other_user_b',
    //       width: 85,
    //       height: 85,
    //       onTap: () => _showPersistantBottomSheetCallBack(),
    //       onMap: true,
    //     )),
    // MapOverlay(
    //     coordinate: LatLng(23.477641, 111.161786),
    //     child: Bubble(
    //       avatar: 'images/avatar.png',
    //       style: 4,
    //     )),
    // MapOverlay(
    //     coordinate: LatLng(23.477641, 111.459786),
    //     child: Bubble(
    //       avatar: 'images/avatar.png',
    //       style: 5,
    //     ))
  ];
}
