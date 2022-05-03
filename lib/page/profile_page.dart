import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/controller/edit_profile_controller.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/services.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserStateController stateController = Get.find();
  final IUserService userService = Get.find();

  void editProfile() async {
    assert(stateController.currentUser.value != null);

    var editController = EditProfileController(
        stateController.currentUser.value!.copyWith().obs);
    Get.put(editController); // Copy a new user object
    await Get.toNamed(RoutePages.editProfile);

    printInfo(info: editController.user.value.toString());
    if (editController.emailValidationError.value ||
        editController.userNameValidationError.value) {
      await Get.dialog(const AlertDialog(
        title: Text("Failed to save profile"),
        content: Text("You have inputted invalid content"),
      ));
      return;
    }

    try {
      UserProfile newProfile = editController.user.value.toUserProfile();
      UserProfile currentProfile =
          stateController.currentUser.value!.toUserProfile();
      UserProfileUpdate update =
          UserProfileUpdate.fromUserProfile(currentProfile, newProfile);
      await userService.updateUserProfile(update);
      stateController.currentUser.updateUserProfile(update);
    } on ApiBrokerException catch (e) {
      Get.dialog(AlertDialog(
        title: const Text("Failed to save profile"),
        content: Text(e.errorMessage),
      ));
    }

    Get.delete<EditProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    assert(stateController.currentUser.value != null);

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(() => ProfileWidget(
                imagePath: stateController.currentUser.value!.avatarPath,
                onClicked: editProfile,
              )),
          const SizedBox(height: 24),
          Obx(() => buildName(stateController.currentUser.value!)),
          const SizedBox(height: 48),
          Obx(() => buildAbout(stateController.currentUser.value!)),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.userName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
