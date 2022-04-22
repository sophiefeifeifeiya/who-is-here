import 'package:flutter/material.dart';
import 'package:whoshere/widgets/MapView.dart';
import 'package:whoshere/mock/mockMapOverLays.dart';
import 'package:whoshere/mock/mockTagList.dart';
import 'package:whoshere/widgets/TagSelector.dart';
import 'package:whoshere/widgets/SearchBarDelegate.dart';
import 'package:whoshere/widgets/FilledIconButton.dart';
import 'package:whoshere/page/profile_page.dart';
import 'package:whoshere/widgets/tapbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTagIndex = 0;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  late VoidCallback _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersistantBottomSheetCallBack = () {};
    });

    _scaffoldKey.currentState
        ?.showBottomSheet((context) {
          return tapBar2();
        })
        .closed
        .whenComplete(() {
          // controller broadcast

          if (mounted) {
            setState(() {
              _showPersistantBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          MapView(
            overlays:
                getMockMapOverLays(context, _showPersistantBottomSheetCallBack),
          ),
          SizedBox(
            width: windowWidth,
            height: statusBarHeight + 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: windowWidth - 40,
                  child: TagSelector(
                    tabTitleList: tagList,
                    select: _selectedTagIndex,
                    onTap: (int index) {
                      setState(() {
                        _selectedTagIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      splashColor: const Color.fromARGB(255, 0, 0, 255),
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context, delegate: SearchBarDelegate());
                      },
                    )),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: FilledIconButton(
                background: Colors.blueAccent,
                cb: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                ),
              ))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
