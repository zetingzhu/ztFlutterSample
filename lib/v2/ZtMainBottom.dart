import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/main.dart';
import 'package:zt_flutter_sample_v2/v2/TPage5.dart';
import 'package:zt_flutter_sample_v2/v2/ZtNavBottomUI.dart';

import 'TPage1.dart';
import 'TPage2.dart';
import 'TPage3.dart';
import 'TPage4.dart';

enum ScreenSelected {
  main(0),
  chat(1),
  rooms(2),
  meet(3),
  setting(4);

  const ScreenSelected(this.value);

  final int value;
}

// 应用主页组件
class ZMyApp extends StatefulWidget {
  const ZMyApp({super.key});

  @override
  State<ZMyApp> createState() => _HomeState();
}

// Home组件的状态类
class _HomeState extends State<ZMyApp> with SingleTickerProviderStateMixin {
  // 当前选中的屏幕索引
  int screenIndex = ScreenSelected.main.value;

  // 处理屏幕切换
  void handleScreenChanged(int screenSelected) {
    setState(() {
      screenIndex = screenSelected;
    });
  }

  // 根据选中的屏幕索引创建对应的屏幕
  Widget createScreenFor(ScreenSelected screenSelected) =>
      switch (screenSelected) {
        ScreenSelected.main => const MyHomePage(),
        ScreenSelected.chat => const TPage2(),
        ScreenSelected.rooms => const TPage3(),
        ScreenSelected.meet => const TPage4(),
        ScreenSelected.setting => const TPage5(),
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 是否显示右上角debug标志
      debugShowCheckedModeBanner: true,
      // 应用标题
      title: "Flutter底部导航栏",
      // 应用主页
      home: Scaffold(
        appBar: AppBar(title: const Text('Material 3')),
        body: createScreenFor(ScreenSelected.values[screenIndex]),
        bottomNavigationBar: NavigationBars(
          onSelectItem: (index) {
            setState(() {
              screenIndex = index;
              handleScreenChanged(screenIndex);
            });
          },
          selectedIndex: screenIndex,
        ),
      ),
    );
  }
}
