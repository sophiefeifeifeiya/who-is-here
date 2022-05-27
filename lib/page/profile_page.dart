import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_exceptions.dart';
import 'package:whoshere/controller/edit_profile_controller.dart';
import 'package:whoshere/controller/user_state_controller.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/page/post/index.dart';
import 'package:whoshere/routes/route_pages.dart';
import 'package:whoshere/service/services.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
<<<<<<< HEAD
import 'package:whoshere/widgets/avatar_widget.dart';
<<<<<<< HEAD
import 'package:whoshere/model/Post.dart';
import 'package:whoshere/widgets/posts.dart';
=======
=======
import 'package:whoshere/widgets/profile_widget.dart';
import 'package:whoshere/model/Post.dart';
import 'package:whoshere/widgets/posts.dart';
>>>>>>> viewMyPost
>>>>>>> 9d65316d3a19484ec39241215115345a3375f770

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

    var editController = EditProfileController(stateController.currentUser);
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
      UserProfile? newProfile = editController.user.value?.toUserProfile();
      if (newProfile != null) {
        UserProfile currentProfile =
            stateController.currentUser.value!.toUserProfile();
        UserProfileUpdate update =
            UserProfileUpdate.fromUserProfile(currentProfile, newProfile);
        await userService.updateUserProfile(update);
        stateController.currentUser.updateUserProfile(update);
      }
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

    print(stateController.currentUser.value);

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(() => AvatarWidget(
                imagePath: stateController.currentUser.value!.avatarPath,
                onClicked: editProfile,
            user: stateController.currentUser.value,
              )),
          const SizedBox(height: 24),
          Obx(() => buildName(stateController.currentUser.value!)),
          const SizedBox(height: 48),
          Obx(() => buildAbout(stateController.currentUser.value!)),
          const SizedBox(height: 20),
          Obx(() => buildPost(stateController.currentUser.value!)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(()=>const PostWritePage());
      },child: const Icon(Icons.add),),
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

  Widget buildPost(User user) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Posts',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
              shrinkWrap: true, itemCount: eileen.length, itemBuilder: myPost),
        ],
      ));

  Widget myPost(context, index) => Container(
        child: Column(
          children: [
            Posts(
              post: eileen[index],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.thumb_up, color: Colors.red),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStateProperty.all(0),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: 	MaterialStateProperty.all(Colors.transparent)
                        ),
                    child: const Icon(Icons.delete, color: Colors.blue),
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return DecoratedBox(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: AlertDialog(
                                title: const Text("Note"),
                                content: const Text("Delete this post?"),
                                actions: <Widget>[
                                  TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () => {
                                        Navigator.pop(context)
                                      }),
                                  const SizedBox(
                                    width: 125,
                                  ),
                                  TextButton(
                                      child: const Text("OK"), onPressed: () => {
                                        Navigator.pop(context)
                                      }),
                                ],
                              ),
                            );
                          });
                    }),
              ],
            ),
          ],
        ),
      );
}
