import 'package:flutter/services.dart';

class BatteryChannel {
  static const _batteryChannelName = "cn.blogss/battery"; // 1.方法通道名称
  static MethodChannel? _batteryChannel;

  static void initChannels() {
    _batteryChannel = MethodChannel(_batteryChannelName); // 2. 实例化一个方法通道
  }

  // 3. 异步任务，通过平台通道与特定平台进行通信，获取电量，这里的宿主平台是 Android
  static getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _batteryChannel?.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return batteryLevel;
  }
}
