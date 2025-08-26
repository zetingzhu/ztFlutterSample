import 'package:flutter/material.dart';

class StackRoute extends StatelessWidget {
  const StackRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        // textDirection: TextDirection.rtl,
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        clipBehavior: Clip.hardEdge,
        // fit: StackFit.expand, //未定位widget占满Stack整个空间
        children: <Widget>[
          Container(
            color: Colors.red,
            child: const Text(
              "Hello world",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Positioned(left: 18.0, child: Text("I am Jack")),
          const Positioned(top: 18.0, child: Text("Your friend")),
          const Positioned(right: 18.0, child: Text("右边")),
          const Positioned(bottom: 30.0, child: Text("下边")),
          const Positioned(bottom: 30.0,right: 10.0, child: Text("右下边")),
          const Positioned(top: 10.0,right: 10.0, child: Text("右上边")),
        ],
      ),
    );
  }
}
