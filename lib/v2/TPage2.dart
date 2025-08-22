import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/chapter2/cupertino_route.dart';
import 'package:zt_flutter_sample_v2/chapter2/state.dart';

class TPage2 extends StatelessWidget {
  const TPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Text("显示内容 2");

    return ListView(
      children: <Widget>[
        mItem(context, 'State 各种状态研究', const CounterWidget(initValue: 10)),
        ListTile(
          title: Text('命名路由'),
          onTap: () => Navigator.pushNamed(context, "new_page"),
        ),
        ListTile(
          title: Text('命名路由,带上参数'),
          onTap: () =>
              Navigator.pushNamed(context, "new_routes", arguments: "hi"),
        ),
      ],
    );
  }
}

Widget mItem(BuildContext context, String str, Widget page) {
  return ListTile(
    title: Text(str),
    trailing: const Icon(Icons.keyboard_arrow_right),
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          // 在这里，我们将传入的 widget 放入一个匿名函数中
          // 以满足 MaterialPageRoute 的 builder 参数要求
          builder: (context) => page,
        ),
      ),
    },
  );
}
