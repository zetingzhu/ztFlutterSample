import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zt_flutter_sample_v2/HomePage.dart';
import 'package:zt_flutter_sample_v2/chapter2/2.4/NewRoutes.dart';
import 'package:zt_flutter_sample_v2/v2/TPage5.dart';
import 'package:zt_flutter_sample_v2/v2/ZtNavBottomUI.dart';
import 'package:zt_flutter_sample_v2/widgets/DoubleClickReturn.dart';
import 'dart:developer';

import '../l10n/LocaleProvider.dart';
import '../l10n/app_localizations.dart';
import '../v5/ThemeProvider.dart';
import 'TPage1.dart';
import 'TPage2.dart';
import 'TPage3.dart';
import 'TPage4.dart';
import 'package:provider/provider.dart';

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
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, child) {
        if (kDebugMode) {
          print("主页启动获取的 provider 语言: ${localeProvider.locale}");
          print("主页启动获取的 provider 主题: ${themeProvider.themeMode}");
        }

        return MaterialApp(
          // 是否显示右上角debug标志
          debugShowCheckedModeBanner: true,
          // 使用 provider 中的 locale
          locale: localeProvider.locale,
          // 使用 provider 中的主题模式
          themeMode: themeProvider.themeMode,
          // 浅色主题
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          // 深色主题
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          // 应用标题
          title: "Flutter底部导航栏",
          // 本地化委托
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          // 支持的语言
          supportedLocales: AppLocalizations.supportedLocales,
          // 应用主页
          home: DoubleClickReturn(
            child: Scaffold(
              appBar: AppBar(
                title: Builder(
                  builder: (context) {
                    if (kDebugMode) {
                      print(
                        "AppLocalizations.of(context) result: ${AppLocalizations.of(context)}",
                      );
                    }
                    return Text(
                      AppLocalizations.of(context)?.zztTitle ??
                          'ZZT Flutter 学习记录',
                    );
                  },
                ),
              ),
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
          ),
          //注册路由表
          routes: {
            "new_page": (context) => NewRouter(),
            "new_routes": (context) => NewRouter(),
          },

          // onGenerateRoute: (RouteSettings settings) {
          //   return MaterialPageRoute(
          //     builder: (context) {
          //       String routeName = settings.name;
          //       // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          //       // 引导用户登录；其他情况则正常打开路由。
          //     },
          //   );
          // },
        );
      },
    );
  }
}
