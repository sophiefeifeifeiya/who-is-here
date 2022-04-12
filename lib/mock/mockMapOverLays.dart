// ignore_for_file: file_names, prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/widgets.dart';
import '../widgets/MapOverlay.dart';
import '../widgets/Bubble.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

var mockMapOverLays = [
  MapOverlay(
    coordinate: LatLng(23.477641, 111.274786),
    child: Bubble(avatar: 'images/avatar.png'),
  ),
  MapOverlay(
      coordinate: LatLng(23.467641, 111.274786),
      child: Bubble(
        avatar: 'images/avatar.png',
        style: 3,
      )),
  MapOverlay(
      coordinate: LatLng(23.477641, 111.260786),
      child: Bubble(
        avatar: 'images/avatar.png',
        style: 2,
      )),
  MapOverlay(
      coordinate: LatLng(23.477641, 111.161786),
      child: Bubble(
        avatar: 'images/avatar.png',
        style: 4,
      )),
  MapOverlay(
      coordinate: LatLng(23.477641, 111.459786),
      child: Bubble(
        avatar: 'images/avatar.png',
        style: 5,
      ))
];
