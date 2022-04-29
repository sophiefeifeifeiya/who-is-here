import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/profile_widget.dart';
import 'package:whoshere/widgets/textfield_widget.dart';
import 'package:whoshere/utils/input_validations.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserStateController stateController = Get.find();

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              Obx(() => ProfileWidget(
                    imagePath: stateController.currentUser.value!.avatarPath,
                    isEdit: true,
                    onClicked: () async {},
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'Full Name',
                    text: stateController.currentUser.value!.userName,
                    onChanged: (name) {
                      // TODO: update backend
                      if (name.isNotEmpty) {
                        stateController.currentUser.update((u) {
                          u!.userName = name;
                        });
                      }
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'Email',
                    text: stateController.currentUser.value!.email,
                    onChanged: (email) {
                      // TODO: update backend
                      if (email.isNotEmpty && email.isValidEmail()) {
                        stateController.currentUser.update((u) {
                          u!.email = email;
                        });
                      }
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'About',
                    text: stateController.currentUser.value!.bio,
                    maxLines: 5,
                    onChanged: (about) {
                      // TODO: update backend
                      if (about.isNotEmpty) {
                        stateController.currentUser.update((u) {
                          u!.bio = about;
                        });
                      }
                    },
                  )),
            ],
          ),
        ),
      );
}
