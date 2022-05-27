// ignore_for_file: prefer_const_constructors

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoshere/api/api_broker.dart';
import 'package:whoshere/controller/chat_controller.dart';
import 'package:whoshere/model/user.dart';
import 'package:whoshere/page/setting_page.dart';
import 'package:whoshere/model/Post.dart';
import 'package:whoshere/utils/navigating.dart';
import 'package:whoshere/widgets/posts.dart';
import 'package:whoshere/widgets/tag.dart';
import 'package:whoshere/model/people.dart';
import 'package:whoshere/routes/route_pages.dart';

class friendPage extends StatelessWidget {
  final Rx<User> friend;

  const friendPage(this.friend, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const menu_bar(),
          info_bar(
            friend: friends[0],
            user: friend.value,
          ),
          const SizedBox(
            height: 15,
          ),
          tag_bar(friend: friends[0]),
          const Divider(
            height: 5.0,
          ),
          SizedBox(
            height: 350.0,
            child: ListView.builder(
                itemCount: eileen.length,
                itemBuilder: (context, index) => Posts(
                      post: eileen[index],
                    )),
          ),
          const Divider(
            height: 5.0,
          ),
          hello_bar(
            user: friend,
          )
        ],
      ),
    );
  }
}

class hello_bar extends StatelessWidget {
  final Rx<User> user;

  const hello_bar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Container(
            height: 35,
            margin: const EdgeInsets.only(left: 12.0, right: 10.0),
            padding: const EdgeInsets.only(bottom: 1.5, right: 2.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.black,
                )),
            child: IconButton(
              icon: const Icon(
                Icons.pan_tool,
                color: Colors.black,
              ),
              onPressed: () {
                openFriendPage(context, user);
              },
            ),
          ),
          Expanded(
            child: Container(
              height: 20.0,
              margin: EdgeInsets.only(right: 10.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.black,
                onPressed: () {
                  Get.put(ChatStateController(user: user),
                      tag: user.value.userId);
                  Get.toNamed(RoutePages.chat, arguments: {"user": user.value});
                },
                child: Text(
                  "Start Chatting".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class tag_bar extends StatelessWidget {
  final People friend;
  const tag_bar({Key? key, required this.friend}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              child: Icon(
            Icons.format_quote,
            size: 50,
            color: Colors.blueGrey,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              tag(friend.tags[0]),
              tag(friend.tags[1]),
              tag(friend.tags[2]),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [tag(friend.tags[3]), tag(friend.tags[4])],
          )
        ],
      ),
    );
  }
}

class menu_bar extends StatelessWidget {
  const menu_bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              context: context,
              builder: (context) => const setting_page(),
              isScrollControlled: false,
              enableDrag: true,
            );
          },
          icon: const Icon(Icons.settings),
          splashRadius: 15,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.call),
          splashRadius: 15,
        ),
      ],
    );
  }
}

class info_bar extends StatelessWidget {
  final People friend;
  final User user;

  final ApiBroker _broker = Get.find();

  info_bar({Key? key, required this.friend, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150.0,
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  user.userName,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  friend.tickle,
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsetsDirectional.only(end: 15.0),
            child: AvatarView(
                avatarType: AvatarType.CIRCLE,
                imagePath:
                    _broker.getAvatarImageUri(user.avatarPath).toString(),
                placeHolder: const Icon(
                  Icons.person,
                  size: 50,
                )),
          ),
        ],
      ),
    );
  }
}
