import 'package:flutter/material.dart';

class CounterWidget  extends StatefulWidget {
  const CounterWidget ({super.key, required this.initValue});

  final int initValue;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget > {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print("initState 初始化");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed: () => setState(() => ++_counter),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate 无效");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose 丢弃");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble 热重载");
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget ");
  }
}