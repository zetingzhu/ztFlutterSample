import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/widgets/page_scaffold.dart';

import '../chapter2/counter.dart';

class HomeRoom extends StatefulWidget {
  const HomeRoom({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeRoomState();
  }
}

class _HomeRoomState extends State<HomeRoom> {
  List<Widget> _generateItem(BuildContext context, List<ZPage> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(
          page.title,
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openPage(context),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: const Text("2.第一个Flutter应用"),
            children: _generateItem(context, [
              ZPage("计数器", const CounterRoute(), withScaffold: false),
            ]),
          ),
        ],
      ),
    );
  }
}
