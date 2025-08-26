import 'package:flutter/material.dart';

class GridviewV4 extends StatefulWidget {
  const GridviewV4({super.key});

  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<GridviewV4> {
  final List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
  return  GridView.extent(
      maxCrossAxisExtent: 120.0,
      childAspectRatio: 2.0,
      children:  _icons.map((icon) => Icon(icon)).toList(),
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200)).then((e) {
      setState(() {
        for (int i = 0; i < 10; i++) {
          _icons.addAll([
            Icons.ac_unit,
            Icons.airport_shuttle,
            Icons.all_inclusive,
            Icons.beach_access,
            Icons.cake,
            Icons.free_breakfast,
          ]);
        }
      });
    });
  }
}
