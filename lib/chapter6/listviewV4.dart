import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:zt_flutter_sample_v2/common.dart';

class ListViewV4 extends StatefulWidget {
  const ListViewV4({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<ListViewV4> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(title: Text("商品列表")),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index.isEven ? Colors.white : Colors.grey[100], // 交替颜色
                child: ListTile(title: Text("$index")),
              );
            },
          ),
        ),
      ],
    );
  }
}
