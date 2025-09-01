import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/v2/ZtMainBottom.dart';
import 'package:provider/provider.dart';
import 'l10n/LocaleProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  runApp(
    ChangeNotifierProvider<LocaleProvider>.value(
      value: localeProvider,
      child: const ZMyApp(),
    ),
  );
}
