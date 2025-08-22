import 'dart:async';
import 'package:flutter/material.dart' hide Page;
import 'HomePage.dart';
import 'common.dart';
import 'routes.dart';
import 'package:flukit/flukit.dart';

void main() {
  runZoned(
    () => runApp(const MyApp()),
    zoneSpecification: ZoneSpecification(
      // 拦截print
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, line);
        logEmitter.value = LogInfo(false, line);
      },
      // 拦截未处理的异步错误
      handleUncaughtError:
          (
            Zone self,
            ZoneDelegate parent,
            Zone zone,
            Object error,
            StackTrace stackTrace,
          ) {
            parent.print(zone, '${error.toString()} $stackTrace');
            // Redirect error log event when error.
            logEmitter.value = LogInfo(true, error.toString());
          },
    ),
  );

  var onError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    logEmitter.value = LogInfo(true, details.toString());
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}
