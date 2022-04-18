// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';

class TagSelector extends StatefulWidget {
  final List<String> tabTitleList;
  final int select;
  final Function(int index) onTap;

  const TagSelector(
      {Key? key,
      required this.tabTitleList,
      this.select = 0,
      required this.onTap})
      : super(key: key);

  @override
  _TagSelectorState createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  List<TabModel> _list = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initDataFunction();
  }

  @override
  void didUpdateWidget(covariant TagSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentIndex = widget.select;
    initDataFunction();
  }

  initDataFunction() {
    _list = [];
    for (int i = 0; i < widget.tabTitleList.length; i++) {
      String title = widget.tabTitleList[i];
      _list.add(TabModel(title: title, select: _currentIndex == i, id: i));
    }
    widget.tabTitleList.forEach((element) {});
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        TabModel _tabModel = _list[index];

        Color bgColor = Colors.grey[200]!;
        Color borderColor = Colors.grey[200]!;
        Color textColor = Colors.black;
        if (_tabModel.select) {
          print('${_tabModel.title} selected');
          bgColor = Colors.white;
          borderColor = Colors.blueAccent;
          textColor = Colors.blueAccent;
        }

        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('====== tapped ======');
                  print(_tabModel.title);
                  if (_tabModel.select) {
                    print('完事了');
                    _tabModel.select = false;
                    return;
                  }
                  int selectIndex = 0;
                  String clickTitle = _tabModel.title;
                  print(clickTitle);
                  // for (int i = 0; i < _list.length; i++) {
                  //   TabModel element = _list[i];
                  //   String title = element.title;
                  //   if (title == clickTitle) {
                  //     element.select = true;
                  //     selectIndex = i;
                  //   }
                  //   else {
                  //     element.select = false;
                  //   }
                  // }
                  _tabModel.select = true;
                  double offset = _scrollController.offset;
                  if (selectIndex <= 2) {
                    _scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  } else if (selectIndex > 2 &&
                      selectIndex < _list.length - 3) {
                    if (selectIndex > _currentIndex) {
                      //向左滑动
                      _scrollController.animateTo(
                        offset + 80.0 + (selectIndex - _currentIndex - 1) * 80,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    } else {
                      //向右滑动
                      _scrollController.animateTo(
                        offset - 60,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    }
                  } else {
                    double max = _scrollController.position.maxScrollExtent;
                    _scrollController.animateTo(
                      max,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  }
                  _currentIndex = selectIndex;

                  setState(() {});
                  widget.onTap(_currentIndex);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    //背景
                    color: bgColor,
                    //边框
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    _tabModel.title,
                    style: TextStyle(color: textColor),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TabModel {
  String title;
  int id;

  //true 为选中
  bool select;

  TabModel({required this.id, required this.title, this.select = false});
}
