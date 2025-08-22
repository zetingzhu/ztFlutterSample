import 'package:flutter/material.dart';

class SwitchAndCheckBoxRoute extends StatefulWidget {
  const SwitchAndCheckBoxRoute({Key? key}) : super(key: key);

  @override
  _SwitchAndCheckBoxRouteState createState() => _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  bool switchS1 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Switch(
              activeThumbImage: const AssetImage('imgs/sunny_24dp.png'),
              // 开启状态滑块图片
              inactiveThumbImage: const AssetImage('imgs/heart_minus_24.png'),
              value: switchS1,
              onChanged: (bool value) {
                setState(() {
                  switchS1 = value;
                });
              }, // 点击涟漪效果大小
            ),
            Switch(
              activeColor: Colors.green,
              // 开启状态滑块颜色
              inactiveThumbColor: Colors.lightBlue,
              //关闭状态滑块颜色
              activeTrackColor: Colors.amber,
              //开启轨道颜色
              inactiveTrackColor: Colors.pinkAccent,
              //关闭轨道颜色
              value: switchS1,
              onChanged: (bool value) {
                setState(() {
                  switchS1 = value;
                });
              }, // 点击涟漪效果大小
            ),
          ],
        ),

        Row(
          children: <Widget>[
            Switch(
              value: _switchSelected, //当前状态
              onChanged: (value) {
                //重新构建页面
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
            const Text("关"),
            Switch(
              value: !_switchSelected, //当前状态
              onChanged: (value) {},
            ),
            const Text("开"),
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value!;
                });
              },
            ),
            const Text("未选中"),
            Checkbox(
              value: !_checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {},
            ),
            const Text("选中"),
          ],
        ),
      ],
    );
  }
}
