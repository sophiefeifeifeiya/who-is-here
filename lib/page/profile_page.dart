import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/page/edit_profile_page.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/profile_widget.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  final UserStateController stateController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(() => ProfileWidget(
            imagePath: stateController.currentUser.value!.avatarPath,
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
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
            user.name,
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
              user.about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
