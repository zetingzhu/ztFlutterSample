import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/widgets/DoubleClickReturn.dart';

class BackPopScope extends StatefulWidget {
  const BackPopScope({super.key});

  @override
  PopScopeState createState() {
    return PopScopeState();
  }
}

class PopScopeState extends State<BackPopScope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('监听返回')),
      body: SafeArea(
        child: DoubleClickReturn(
          child: Container(
            alignment: Alignment.center,
            child: const Text("2秒内连续按两次返回键退出"),
          ),
        ),
      ),
    );
  }
}
