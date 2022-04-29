import 'package:flutter/material.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/widgets/appbar_widget.dart';
import 'package:whoshere/widgets/profile_widget.dart';
import 'package:whoshere/widgets/textfield_widget.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User user = User(
      userId: "",
      avatarPath: "imagePath",
      userName: "name",
      email: "email",
      bio: "about",
      isDarkMode: false,
      location: LatLng(0, 0));

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.avatarPath,
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: user.userName,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text: user.bio,
                maxLines: 5,
                onChanged: (about) {},
              ),
            ],
          ),
        ),
      );
}
