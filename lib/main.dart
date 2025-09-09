import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/v2/ZtMainBottom.dart';
import 'package:provider/provider.dart';
import 'l10n/LocaleProvider.dart';
import 'v5/ThemeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化语言提供者
  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // 初始化主题提供者
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ],
      child: const ZMyApp(),
    ),
  );
}
