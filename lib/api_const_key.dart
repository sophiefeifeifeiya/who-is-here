import 'package:amap_flutter_base/amap_flutter_base.dart';

/// Stores constant, secret and access key related to external API
abstract class ApiConstKey {
  static const String amapAndroidApiKey = "f9648f64a9a370e7dc8e09c63ac2cbc1";
  static const String amapIosApiKey = "c166816f949c6c796c329e0c62968d34";
  static const AMapPrivacyStatement amapPrivacyStatement = AMapPrivacyStatement(
  hasContains: true, hasShow: true, hasAgree: true);
}