import 'package:flutter/material.dart';

class ContainerRoute extends StatelessWidget {
  const ContainerRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50.0, left: 120.0),
          constraints: const BoxConstraints.tightFor(
            width: 200.0,
            height: 150.0,
          ),
          //卡片大小
          decoration: const BoxDecoration(
            //背景装饰
            gradient: RadialGradient(
              //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98,
            ),
            boxShadow: [
              //卡片阴影
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          transform: Matrix4.rotationZ(.2),
          //卡片倾斜变换
          alignment: Alignment.bottomRight,
          //卡片内文字居中
          child: const Text(
            //卡片文字
            "这个卡片长文字",
            style: TextStyle(color: Colors.white, fontSize: 40.0),
          ),
        ),
        Divider(height: 40),
        Container(
          margin: const EdgeInsets.only(top: 50.0, left: 120.0),
          constraints: const BoxConstraints.tightFor(
            width: 200.0,
            height: 150.0,
          ),
          //卡片大小
          decoration: const BoxDecoration(
            //背景装饰
            gradient: RadialGradient(
              //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98,
            ),
            boxShadow: [
              //卡片阴影
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          // transform: Matrix4.rotationZ(.2),
          //卡片倾斜变换
          alignment: Alignment.center,
          //卡片内文字居中
          child: const Text(
            textAlign: TextAlign.center,
            //卡片文字
            "这个文字怎么不居中",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),

        Divider(height: 40),
        Divider(height: 0, color: Colors.blue),
        Container(
          margin: EdgeInsets.all(20.0), //容器外补白
          color: Colors.orange,
          child: Text("Hello world!"),
        ),

        Divider(height: 0, color: Colors.blue),
        Container(
          padding: EdgeInsets.all(20.0), //容器内补白
          color: Colors.orange,
          child: Text("Hello world!"),
        ),
        Divider(height: 0, color: Colors.blue),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("Hello world!"),
          ),
        ),
        Divider(height: 0, color: Colors.blue),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.orange),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Hello world!"),
          ),
        ),
        Divider(height: 0, color: Colors.blue),
      ],
    );
  }
}
