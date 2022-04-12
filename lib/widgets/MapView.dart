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
      print("Overlay UI position: x: ${point.x}  y: ${point.y}");
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
    devicePixelRatio = media.devicePixelRatio;
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
            initialCameraPosition:
                CameraPosition(target: LatLng(23.476733, 111.279022), zoom: 16),
          ),
          // Positioned(
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     color: Colors.green,
          //   ),
          //   right: 50,
          //   bottom: 50,
          // ),
          Stack(
            children: visibleOverlays,
          )
        ],
      ),
    );
  }
}
