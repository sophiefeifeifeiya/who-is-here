import 'dart:async';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:coord_convert/coord_convert.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/api_const_key.dart';
import 'package:whoshere/model/user.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:whoshere/service/services.dart';

class UserLocationService implements IUserLocationService {
  final StreamController<LatLng> _updateController = StreamController<LatLng>();
  final AMapFlutterLocation _location = AMapFlutterLocation();
  final ApiBroker _broker = Get.find();

  LatLng _lastUpdateLocation =
      const LatLng(31.239703, 121.499718); // default initial location: Shanghai
  bool _started = false;

  UserLocationService() {
    AMapFlutterLocation.updatePrivacyAgree(true);
    AMapFlutterLocation.updatePrivacyShow(true, true);
    AMapFlutterLocation.setApiKey(
        ApiConstKey.amapAndroidApiKey, ApiConstKey.amapIosApiKey);
  }

  @override
  LatLng get currentLocation => _lastUpdateLocation;

  @override
  Future<List<User>> getNearbyUsers() async {
    List<User> users = await _broker.getNearbyUsers(CoordConvert.gcj02towgs84(
        Coords(_lastUpdateLocation.latitude, _lastUpdateLocation.longitude)));

    // Convert WGS-084 back to GCJ-02
    for (var u in users) {
      Coords gcjCoord = CoordConvert.wgs84togcj02(
          Coords(u.location.latitude, u.location.longitude));
      u.location = LatLng(gcjCoord.latitude, gcjCoord.longitude);
    }

    return users;
  }

  @override
  Stream<LatLng> get onLocationUpdate => _updateController.stream;

  void _onLocationUpdate(Map<String, dynamic> update) {
    if (update["latitude"] != null) {
      var loc = LatLng(update["latitude"], update["longitude"]);
      _lastUpdateLocation = loc;
      _updateController.sink.add(loc);
    } else {
      // print error
      printError(info: update.toString());
    }

  }

  @override
  void startLocationUpdate() {
    if (_started) {
      return;
    }

    _location.onLocationChanged().listen(_onLocationUpdate);
    _location.startLocation();
    _started = true;
  }

  @override
  void stopLocationUpdate() {
    _location.stopLocation();
  }

  @override
  void dispose() {
    _location.destroy();
  }
}
