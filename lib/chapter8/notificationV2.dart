import 'package:flutter/material.dart';

class NotificationV2 extends StatefulWidget {
  const NotificationV2({super.key});

  @override
  NotificationRouteState createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationV2> {
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener(
      onNotification: (notification) {
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            print("开始滚动");
            break;
          case ScrollUpdateNotification:
            print("正在滚动");
            break;
          case ScrollEndNotification:
            print("滚动停止");
            break;
          case OverscrollNotification:
            print("滚动到边界");
            break;
        }
        return false;
      },
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text("$index"));
        },
      ),
    );
  }
}
