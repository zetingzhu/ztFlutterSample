import 'package:flutter/cupertino.dart';

class SafeAreaSample extends StatefulWidget {
  const SafeAreaSample({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SafeAreaSample();
  }
}

class _SafeAreaSample extends State<SafeAreaSample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Hello Flutter"));
    // return Text("Hello Flutter");
    // return Padding(
    //   padding: EdgeInsets.only(
    //     top: MediaQuery.of(context).padding.top,
    //     bottom: MediaQuery.of(context).padding.bottom,
    //     left: MediaQuery.of(context).padding.left,
    //     right: MediaQuery.of(context).padding.right,
    //   ),
    //   child: Text("Hello Flutter"),
    // );
  }
}
