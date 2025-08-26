import 'package:flutter/material.dart';

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({super.key});

  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animationController.forward();
    _animationController.addListener(
      () => setState(() => {print("看看这个动画值：${_animationController.value}")}),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:
            <Widget>[
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
              SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
              ),
              SizedBox(
                height: 100,
                width: 130,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  value: .7,
                ),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(
                  begin: Colors.grey,
                  end: Colors.blue,
                ).animate(_animationController),
                value: _animationController.value,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.red[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: _animationController.value,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(
                  begin: Colors.grey,
                  end: Colors.blue,
                ).animate(_animationController),
                value: _animationController.value,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: ColorTween(
                  begin: Colors.grey,
                  end: Colors.blue,
                ).animate(_animationController),
              ),
              ElevatedButton(
                onPressed: () {
                  _animationController.value = 0.0;
                  _animationController.forward();
                },
                child: Text('重置动画'),
              ),
            ].map((e) {
              return Padding(padding: const EdgeInsets.all(16), child: e);
            }).toList(),
      ),
    );
  }
}
