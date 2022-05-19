import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/controller/edit_profile_controller.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/avatar_widget.dart';
import 'package:whoshere/widgets/textfield_widget.dart';
import 'package:whoshere/utils/input_validations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController stateController = Get.find();

  // // 图片文件
  // // File _image;
  // // 实例化
  // final ImagePicker _picker = ImagePicker();
  // // 获取图片
  // Future getImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(
  //     // 拍照获取图片
  //     // source: ImageSource.camera,
  //     // 手机选择图库
  //     source: ImageSource.gallery,
  //     // 图片的最大宽度
  //     // maxWidth: 400
  //   );
  //   // 更新状态
  //   setState(() {
  //     if (pickedFile != null) {
  //       stateController.user.value.avatarPath = pickedFile.path; // 更新头像
  //       // 上传图片到服务器
  //       // uploadImg(image.path);
  //     } else {
  //       print('没有选择任何图片');
  //     }
  //   });
  // }

  File? image;
  File? imageTemp;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      setState(() {
        stateController.user.value.avatarPath = image.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;

      setState(() {
        stateController.user.value.avatarPath = image.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              Obx(() => AvatarWidget(
                    imagePath: stateController.user.value.avatarPath,
                    isEdit: true,
                    onClicked: () async {
                      await pickImage();
                      // await pickCamera();
                    },
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
