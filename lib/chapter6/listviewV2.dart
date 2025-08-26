import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class ListViewV2 extends StatefulWidget {
  const ListViewV2({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<ListViewV2> {
  static const loadingTag = "##loading##"; //表尾标记
  final _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemExtent: 50.0, //强制高度为50.0
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("$index"));
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
