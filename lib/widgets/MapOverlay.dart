import 'package:flutter/widgets.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class MapOverlay extends StatelessWidget {
  const MapOverlay({Key? key, required this.coordinate, required this.child})
      : super(key: key);

  final LatLng coordinate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
