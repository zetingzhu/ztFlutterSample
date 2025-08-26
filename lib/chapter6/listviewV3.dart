import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ListViewV3 extends StatefulWidget {
  const ListViewV3({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<ListViewV3> {
  static const loadingTag = "##loading##"; //表尾标记
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(color: Colors.blue);
    Widget divider2 = Divider(color: Colors.green);
    return ListView.separated(
      itemCount: 100,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        final result = generateWordPairs()
            .take(20)
            .map((item) => item.asPascalCase)
            .toList();
        final insIndex = _words.length - 1;
        print("随机生成之前数据： ${insIndex}");
        //重新构建列表
        _words.insertAll(insIndex, result);
      });
    });
  }
}
