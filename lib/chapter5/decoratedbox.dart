import 'package:flutter/material.dart';

class DecoratedBoxRoute extends StatelessWidget {
  const DecoratedBoxRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.orange]),
            //背景渐变
            borderRadius: BorderRadius.circular(10.0),
            //3像素圆角
            boxShadow: const [
              //阴影
              BoxShadow(
                color: Colors.red,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text("Login", style: TextStyle(color: Colors.white)),
          ),
        ),

        Divider(height: 40.0),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white10, //颜色
            border: Border.all(color: Colors.blue, width: 2.0), //蓝色边框
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text("Login", style: TextStyle(color: Colors.blue)),
          ),
        ),

        Divider(height: 40.0),
        SizedBox(
          width: 100,
          height: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              image: const DecorationImage(
                image: AssetImage("imgs/avatar.png"),
                //alignment: Alignment.topLeft
              ),
            ),
          ),
        ),
        Divider(height: 40.0),
        SizedBox(
          width: 100,
          height: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: const DecorationImage(
                image: AssetImage("imgs/avatar.png"),
                //alignment: Alignment.topLeft
              ),
            ),
          ),
        ),
      ],
    );
  }
}
