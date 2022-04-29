import 'dart:math';

import 'package:uuid/uuid.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/service/user_location_service.dart';
import 'package:faker/faker.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class SemiMockUserLocationService extends UserLocationService {
  @override
  Future<List<User>> getNearbyUsers() async {
    List<User> users = await super.getNearbyUsers();
    if (users.length < 10) {
      for (int i = 0; i < 5; i++) {
        users.add(_newMockUser());
      }
    }

    return users;
  }

  User _newMockUser() {
    var faker = Faker();
    var rand = Random();
    var latitudeOffset = (rand.nextDouble() - 0.5) * 0.1;
    var longitudeOffset = (rand.nextDouble() - 0.5) * 0.1;

    return User(
        userId: "mock-${Uuid().v4()}",
        avatarPath: "/avatar_images/default_avatar_${rand.nextInt(7) + 1}.jpg",
        name: faker.internet.userName(),
        email: faker.internet.email(),
        bio: faker.lorem.sentence(),
        location: LatLng(currentLocation.latitude + latitudeOffset,
            currentLocation.longitude + longitudeOffset));
  }
}
