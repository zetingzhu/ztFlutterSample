import 'package:flutter/material.dart' hide Page;
import '../common.dart';

class PointerRoute extends StatelessWidget {
  const PointerRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListPage(
      children: [
        Page('显示移动偏移', const PointerMoveIndicator()),
        Page('AbsorbPointer 忽略响应事件', const ListenerV2()),
        Page('IgnorePointer 忽略响应事件', const ListenerV3()),
      ],
    );
  }
}

class PointerMoveIndicator extends StatefulWidget {
  const PointerMoveIndicator({Key? key}) : super(key: key);

  @override
  _PointerMoveIndicatorState createState() => _PointerMoveIndicatorState();
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicator> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,
        child: Text(
          '相对于全局坐标的偏移:${_event?.position} \n 相对于本身布局坐标的偏移:${_event!.localPosition}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
      onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }
}

class ListenerV2 extends StatefulWidget {
  const ListenerV2({super.key});

  @override
  ListenerV2State createState() {
    return ListenerV2State();
  }
}

class ListenerV2State extends State<ListenerV2> {
  var eventString = "";

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: AbsorbPointer(
        child: Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.red,
            width: 200.0,
            height: 100.0,
            child: Text(eventString),
          ),
          onPointerDown: (event) {
            setState(() {
              eventString = 'in';
            });
          },
        ),
      ),
      onPointerDown: (event) {
        setState(() {
          eventString = 'up';
        });
      },
    );
  }
}

class ListenerV3 extends StatefulWidget {
  const ListenerV3({super.key});

  @override
  ListenerState createState() {
    return ListenerState();
  }
}

class ListenerState extends State<ListenerV3> {
  var eventString = "";

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: IgnorePointer(
        child: Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.red,
            width: 200.0,
            height: 100.0,
            child: Text(eventString),
          ),
          onPointerDown: (event) {
            setState(() {
              eventString = 'in';
            });
          },
        ),
      ),
      onPointerDown: (event) {
        setState(() {
          eventString = 'up';
        });
      },
    );
  }
}
