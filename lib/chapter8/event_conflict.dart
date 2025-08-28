import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EventConflictTest extends StatelessWidget {
  const EventConflictTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('GestureDetector  是监听手势'),
        GestureDetector(
          onTapUp: (x) => print("2"), // 监听父组件 tapUp 手势
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              //GestureDetector1
              onTapUp: (x) => print("1"), // 监听子组件 tapUp 手势
              child: Container(width: 50, height: 50, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 20, child: Text('Listener 是监听原始指针事件')),
        Listener(
          onPointerUp: (x) => print("2"),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => print("1"),
              child: Container(width: 50, height: 50, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 20, child: Text('自定义手势')),
        customGestureDetector(
          onTap: () => print("2"),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => print("1"),
              child: Container(width: 50, height: 50, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //不，我不要失败，我要成功
    //super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}

RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    child: child,
    gestures: {
      CustomTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
            () => CustomTapGestureRecognizer(),
            (detector) {
              detector.onTap = onTap;
              detector.onTapDown = onTapDown;
            },
          ),
    },
  );
}
