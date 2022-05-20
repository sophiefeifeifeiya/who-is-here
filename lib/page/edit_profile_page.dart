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
// import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final EditProfileController stateController = Get.find();

  File? image;
  File? imageTemp;

  /// 返回一个选择图片的路径
  Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return '';
      // final imageTemp = File(image.path);
      // this.image = imageTemp;
      // add image to assets folder
      // print("What is going on" +
      //     stateController.user.value.avatarPath.toString());
      // print("What is going on" + imageTemp.path.toString());
      // await stateController.user.value.uploadAvatar(imageTemp);

      return image.path;

      /// 不要放在这里啦
      // final user = stateController.user.value;
      // if (user != null) {
      //   user.avatarPath = image.path;
      // }

      // stateController.user.update((u) {
      //   u?.avatarPath = image.path;
      // });
      // print("What is going on" +
      //     stateController.user.value.avatarPath.toString());
      // print("What is going on" + imageTemp.path.toString());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return '';
    }
  }

  // Future pickCamera() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     this.image = imageTemp;

  //     // add image to assets folder
  //     print("What is going on" + imageTemp.path.toString());
  //     // stateController.user.value.avatarPath = imageTemp.path;
  //     setState(() {});
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

//前往getx更新user path属性
  void _handleImagePath(String path) {
    if (path.isEmpty) return;
    stateController.updateUserAvatarPath(path);
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              /// ??? 写法有问题
              Obx(() {
                final avatarPath = stateController.user.value?.avatarPath;

                print('===|||||$avatarPath');
                if (avatarPath == null) {
                  return GestureDetector(
                    onTap: () async {
                      final imagePath = await pickImage(); // 接收图片路径
                      _handleImagePath(imagePath);
                    },
                    child: const SizedBox(
                      width: 64,
                      height: 64,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                  );
                }

                final avaPath = stateController.avaPath.value;

                return AvatarWidget(
                  imagePath: avaPath.isNotEmpty ? avaPath : avatarPath,
                  isEdit: true,
                  onClicked: () async {
                    final imagePath = await pickImage();
                    _handleImagePath(imagePath);
                    // await pickCamera();
                  },
                );
              }),
              const SizedBox(height: 24),
              Obx(() => TextFieldWidget(
                    label: 'Full Name',
                    text: stateController.user.value?.userName ?? "空",
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
                    text: stateController.user.value?.email ?? '空',
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
                    text: stateController.user.value?.bio ?? '关于',
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

  // _upLoadImage(File image) async {
  //   String path = image.path;
  //   var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  //   var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
  //   FormData formData = new FormData.from({
  //     "userId": "10000024",
  //     "file": new MultipartFile(new File(path), name,
  //         contentType: ContentType.parse("image/$suffix"))
  //   });

  //   Dio dio = new Dio();
  //   var respone = await dio.post<String>("/upload", data: formData);
  //   if (respone.statusCode == 200) {
  //     Fluttertoast.showToast(
  //         msg: "图片上传成功", gravity: ToastGravity.CENTER, textColor: Colors.grey);
  //   }
  // }
}
