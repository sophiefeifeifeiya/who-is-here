
import 'package:flutter/material.dart';

typedef SearchItemCall = void Function(String item);

class SearchBarDelegate extends SearchDelegate {

  @override
  List <Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面
    return const Center(
      child: Text('12312321'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //点击了搜索窗显示的页面
    return SearchContentView();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }
}

class SearchContentView extends StatefulWidget {
  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State {
  List HotSearch = [
    'xjtlu',
    '隔离中',
    '未返校',   
    'ics',
    '大三',
  ];

  List HistorySearch = [
    '暑假',
    'CPT202',
    '男生',
    '女生'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              '热搜',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HotSearch[0]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HotSearch[1]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HotSearch[2]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HotSearch[3]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HotSearch[4]),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          //SearchItemView(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              '历史记录',
              style: TextStyle(fontSize: 16),
            ),
          ),
          //SearchItemView()
          const Divider(),
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HistorySearch[0]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HistorySearch[1]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HistorySearch[2]),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(HistorySearch[3]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

