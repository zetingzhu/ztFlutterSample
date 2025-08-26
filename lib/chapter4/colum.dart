import 'package:flutter/material.dart';

class ColumLayout extends StatelessWidget {
  const ColumLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Text("hi"), Text("world")],
    );
  }
}
