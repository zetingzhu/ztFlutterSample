import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 双击退出当前页面
class DoubleClickReturn extends StatefulWidget {
  const DoubleClickReturn({super.key, required this.child});

  final Widget child;

  @override
  DoubleClickReturnState createState() {
    return DoubleClickReturnState();
  }
}

class DoubleClickReturnState extends State<DoubleClickReturn> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 设置为false，由我们自己控制是否可以返回
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        // didPop为false表示拦截了返回操作
        if (!didPop) {
          // 处理返回事件，但不返回结果
          bool shouldPop = await _handlePopWithResult();
          if (!mounted) {
            return;
          }
          if (shouldPop) {
            // 在使用context前再次检查mounted状态
            Navigator.of(context).pop();
          }
        }
      },
      child: widget.child,
    );
  }

  // 处理返回按钮点击并返回结果
  Future<bool> _handlePopWithResult() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) >
            const Duration(seconds: 1)) {
      // 两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();

      Fluttertoast.showToast(
        msg: "再按一次退出",
        toastLength: Toast.LENGTH_SHORT,
        // 显示时长
        gravity: ToastGravity.BOTTOM,
        // 位置
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // 返回false表示不允许退出
      return false;
    } else {
      // 两次点击间隔小于1秒，允许退出
      // 这里返回true后，框架会自动调用Navigator.pop()
      return true;
    }
  }
}
