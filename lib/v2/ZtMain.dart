import 'package:flutter/material.dart';

import '../v3/constants.dart';
import 'MainPage.dart';
import 'homeV2.dart';

void main() {
  runApp(ZMyApp());
}

class ZMyApp extends StatefulWidget {
  // @override
  // State<StatefulWidget> createState() {
  //   return AppState();
  // }

  @override
  State<ZMyApp> createState() => _AppState();
}

class AppState extends State<ZMyApp> {
  ThemeMode themeMode = ThemeMode.system;

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter底部导航栏",
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      home: MainPage(),
    );
  }
}

class _AppState extends State<ZMyApp> {
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url))
        .then((newScheme) {
      setState(() {
        colorSelectionMethod = ColorSelectionMethod.image;
        imageSelected = ColorImageProvider.values[value];
        imageColorScheme = newScheme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // false 隐藏右上角debug字样角标
      debugShowCheckedModeBanner: true,
      title: "Flutter底部导航栏",
      home: Home(
        colorSelected: colorSelected,
        imageSelected: imageSelected,
        handleColorSelect: handleColorSelect,
        handleImageSelect: handleImageSelect,
        colorSelectionMethod: colorSelectionMethod,
      ),
    );
  }
}
