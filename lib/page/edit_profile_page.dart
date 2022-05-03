import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/controller/edit_profile_controller.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/profile_widget.dart';
import 'package:whoshere/widgets/textfield_widget.dart';
import 'package:whoshere/utils/input_validations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController stateController = Get.find();

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              Obx(() => ProfileWidget(
                    imagePath: stateController.user.value.avatarPath,
                    isEdit: true,
                    onClicked: () async {},
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'Full Name',
                    text: stateController.user.value.userName,
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        stateController.userNameValidationError.value = true;
                        return "User name cannot be null";
                      }
                      stateController.userNameValidationError.value = false;
                      return null;
                    },
                    onChanged: (name) {
                      stateController.user.update((u) {
                        u?.userName = name;
                      });
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'Email',
                    text: stateController.user.value.email,
                    validator: (String? s) {
                      if (s == null) {
                        stateController.emailValidationError.value = true;
                        return "Email cannot be null";
                      } else if (!s.isValidEmail()) {
                        stateController.emailValidationError.value = true;
                        return "Please enter a valid email address";
                      }
                      stateController.emailValidationError.value = false;
                      return null;
                    },
                    onChanged: (email) {
                      stateController.user.update((u) {
                        u?.email = email;
                      });
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'About',
                    text: stateController.user.value.bio,
                    maxLines: 5,
                    onChanged: (about) {
                      if (about.isNotEmpty) {
                        stateController.user.update((u) {
                          u?.bio = about;
                        });
                      }
                    },
                  )),
            ],
          ),
        ),
      );
}
