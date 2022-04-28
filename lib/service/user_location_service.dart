import 'dart:async';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:whoshere/api_const_key.dart';
import 'package:whoshere/model/user.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:whoshere/service/services.dart';

class UserLocationService implements IUserLocationService {
  final StreamController<LatLng> _updateController = StreamController<LatLng>();
  final AMapFlutterLocation _location = AMapFlutterLocation();

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
  List<User> getNearbyUsers() {
    // TODO: implement getNearbyUsers
    throw UnimplementedError();
  }

  @override
  // TODO: implement locationUpdateController
  Stream<LatLng> get onLocationUpdate => _updateController.stream;

  void _onLocationUpdate(Map<String, dynamic> update) {
    var loc = LatLng(update["latitude"], update["longitude"]);
    // print("Location update: ${loc.toString()}");
    _lastUpdateLocation = loc;
    _updateController.sink.add(loc);
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
