import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:whoshere/model/Post.dart';
import 'package:whoshere/widgets/posts.dart';
import 'package:whoshere/widgets/tag.dart';
import 'package:whoshere/model/people.dart';

class strangerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const menu_bar(),
          info_bar(
            stranger: strangers[0],
          ),
          const SizedBox(
            height: 15,
          ),
          tag_bar(stranger: strangers[0]),
          const Divider(
            height: 5.0,
          ),
          SizedBox(
            height: 400.0,
            child: ListView.builder(
                itemCount: smith.length,
                itemBuilder: (context, index) => Posts(
                      post: smith[index],
                    )),
          ),
          const Divider(
            height: 5.0,
          ),
          const hello_bar()
        ],
      ),
    );
  }
}

class hello_bar extends StatelessWidget {
  const hello_bar({
    Key? key,
  }) : super(key: key);

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
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              height: 35.0,
              margin: const EdgeInsets.only(right: 10.0),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.black,
                onPressed: () {},
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
  final People stranger;
  const tag_bar({Key? key, required this.stranger}) : super(key: key);
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
              tag(stranger.tags[0]),
              tag(stranger.tags[1]),
              tag(stranger.tags[2]),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [tag(stranger.tags[3]), tag(stranger.tags[4])],
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
            // uncomment to display setting page
            // showModalBottomSheet(
            //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //   context: context,
            //   builder: (context)=>setting_page(),
            //   isScrollControlled: false,
            //   enableDrag: true,
            // );
          },
          icon: const Icon(Icons.location_off),
          splashRadius: 15,
        ),
      ],
    );
  }
}

class info_bar extends StatelessWidget {
  final People stranger;

  const info_bar({Key? key, required this.stranger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150.0,
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  stranger.name,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  stranger.tickle,
                  style: const TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsetsDirectional.only(end: 15.0),
            child: AvatarView(
                avatarType: AvatarType.CIRCLE,
                imagePath: stranger.profile,
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
