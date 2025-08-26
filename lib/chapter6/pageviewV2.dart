import 'dart:ui';

import 'package:flutter/material.dart';
import '../routes.dart';
import 'dart:math' as math;

class PageViewV2 extends StatefulWidget {
  const PageViewV2({super.key});

  @override
  _PageViewTestState createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewV2> {
  PageController pageController = PageController();

  int buildType = 1;
  Axis scrollDirection = Axis.horizontal;
  bool reverse = false;
  bool pageSnapping = true;
  bool withPageStorageKey = false;
  bool wrapWithKeepAliveWrapper = false;
  bool allowImplicitScrolling = false;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    // 生成 6 个 Tab 页
    for (int i = 0; i < 6; ++i) {
      children.add(Tab(text: '$i'));
    }

    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            scrollDirection: Axis.horizontal, // 滑动方向为垂直方向
            children: children,
          ),
        ),
        Divider(height: 10, color: Colors.blue),
        Expanded(
          flex: 1,
          child: PageView(
            scrollDirection: Axis.vertical, // 滑动方向为垂直方向
            children: children,
          ),
        ),
      ],
    );
  }
}

// Tab 页面
class Tab extends StatefulWidget {
  const Tab({super.key, required this.text});

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Tab> {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }
}
