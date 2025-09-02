import 'package:flutter/material.dart';

import 'entiy/BatteryChannel.dart';

class BatteryRoute extends StatefulWidget {
  const BatteryRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return BatteryRouteState();
  }
}

class BatteryRouteState extends State<BatteryRoute> {
  String _batteryLevel = 'Unknown battery level.';
  // 3.异步获取到电量，然后重新渲染页面
  getBatteryLevel() async{
    _batteryLevel = await BatteryChannel.getBatteryLevel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BatteryChannel.initChannels();  // 1. 初始化通道
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BatteryRoute"),
        centerTitle: true,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new ElevatedButton(
              child: new Text('Get Battery Level'),
              onPressed: (){
                getBatteryLevel();  // 2. 调用通道方法
              },
            ),
            new Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
