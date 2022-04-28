import 'dart:io';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whoshere/api_const_key.dart';

import 'MapOverlay.dart';

class MapView extends StatefulWidget {
  const MapView(
      {Key? key,
      this.overlays,
      this.initialCameraPosition,
      this.mapCreatedCallback})
      : super(key: key);

  final List<MapOverlay>? overlays;
  final CameraPosition? initialCameraPosition;
  final MapCreatedCallback? mapCreatedCallback;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const AMapApiKey _amapApiKeys = AMapApiKey(
      androidKey: ApiConstKey.amapAndroidApiKey,
      iosKey: ApiConstKey.amapIosApiKey);

  AMapController? controller;
  List<Widget> visibleOverlays = [];
  double devicePixelRatio = 1; // default to 1, will be updated in build()

  void onMapCreated(AMapController controller) {
    this.controller = controller;
    controller.setRenderFps(60);
    updateOverlays();

    widget.mapCreatedCallback?.call(controller);
  }

  void onCameraMove(CameraPosition position) async {
    updateOverlays();
  }

  void updateOverlays() async {
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
      // print(
      //     "Overlay UI position: x: ${point.x}  y: ${point.y}    Pixel ratio: ${devicePixelRatio}");
      visibleOverlays.add(Positioned(
        child: FractionalTranslation(
          translation: const Offset(-0.5, -0.5),
          child: overlay,
        ),
        left: point.x.toDouble() / devicePixelRatio,
        top: point.y.toDouble() / devicePixelRatio,
      ));
    }

    setState(() {
      this.visibleOverlays = visibleOverlays;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller!.disponse();
    }
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
            privacyStatement: ApiConstKey.amapPrivacyStatement,
            initialCameraPosition: widget.initialCameraPosition ??
                const CameraPosition(
                    target: LatLng(39.909187, 116.397451), zoom: 10),
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
