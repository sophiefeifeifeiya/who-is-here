import 'dart:io';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MapOverlay.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key, this.overlays}) : super(key: key);

  final List<MapOverlay>? overlays;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const AMapApiKey _amapApiKeys = AMapApiKey(
      androidKey: 'f9648f64a9a370e7dc8e09c63ac2cbc1',
      iosKey: 'c166816f949c6c796c329e0c62968d34');

  AMapController? controller;
  List<Widget> visibleOverlays = [];
  double devicePixelRatio = 1; // default to 1, will be updated in build()

  void onMapCreated(AMapController? controller) {
    this.controller = controller;
    controller?.setRenderFps(60);
    setupOverlays();
  }

  void onCameraMove(CameraPosition position) async {
    setupOverlays();
  }

  void setupOverlays() async {
    if (widget.overlays == null || controller == null) {
      return;
    }

    var visibleOverlays = <Widget>[];
    for (MapOverlay overlay in widget.overlays!) {
      Point? point = await controller!
          .convertCoordinateToScreen(position: overlay.coordinate);
      if (point == null) {
        continue;
      }
      print(
          "Overlay UI position: x: ${point.x}  y: ${point.y}    Pixel ratio: ${devicePixelRatio}");
      visibleOverlays.add(Positioned(
        child: overlay,
        left: point.x.toDouble() / devicePixelRatio,
        top: point.y.toDouble() / devicePixelRatio,
      ));
    }

    setState(() {
      this.visibleOverlays = visibleOverlays;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    Size parentSize = media.size;
    if (Platform.isIOS) {
      devicePixelRatio = media.textScaleFactor;
    } else {
      devicePixelRatio = media.devicePixelRatio;
    }
    return SizedBox(
      height: parentSize.height,
      width: parentSize.width,
      child: Stack(
        children: [
          AMapWidget(
            onMapCreated: onMapCreated,
            onCameraMove: onCameraMove,
            privacyStatement: const AMapPrivacyStatement(
                hasContains: true, hasShow: true, hasAgree: true),
            initialCameraPosition: const CameraPosition(
                target: LatLng(23.476733, 111.279022), zoom: 16),
            apiKey: _amapApiKeys,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: visibleOverlays,
          )
        ],
      ),
    );
  }
}
