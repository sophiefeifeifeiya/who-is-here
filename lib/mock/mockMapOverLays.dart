import '../widgets/MapOverlay.dart';
import '../widgets/Bubble.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

const mockMapOverLays = [
  MapOverlay(
      coordinate: LatLng(23.477641, 111.274786),
      child: Bubble(avatar: 'images/avatar.png')),
  MapOverlay(
      coordinate: LatLng(23.477641, 111.254786),
      child: Bubble(avatar: 'images/avatar.png', style: 2)),
  MapOverlay(
      coordinate: LatLng(23.277641, 111.254786),
      child: Bubble(avatar: 'images/avatar.png'))
];
