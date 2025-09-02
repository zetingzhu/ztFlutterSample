import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageState extends StatefulWidget {
  const SendMessageState({super.key});

  @override
  State<SendMessageState> createState() => _SendMessageStateState();
}

class _SendMessageStateState extends State<SendMessageState> {
  // 通道名称，Android端和Flutter端的，相互通信的通道，两端必须一致
  final String mChannelName = 'com.example.v3.channel';

  // Android原生View 在Flutter引擎上注册的唯一标识，在Flutter端使用时必须一样
  final String viewType = 'com.example.v3.channel.viewType';

  // Flutter端 向 Android端 发送数据
  static const String FLUTTER_TO_ANDROID = 'flutterToAndroid';

  // Flutter端 获取 Android端 数据
  static const String FLUTTER_GET_ANDROID = 'flutterGetAndroid';

  // Android端 向 Flutter端 发送数据
  static const String ANDROID_TO_FLUTTER = 'androidToFlutter';

  // Android端 获取 Flutter端 数据
  static const String ANDROID_GET_FLUTTER = 'androidGetFlutter';

  late MethodChannel mChannel;

  // flutter 记录数据
  final ValueNotifier<int> curNumFlutter = ValueNotifier<int>(11);

  // android 发送数据
  final ValueNotifier<int> fromAndroid = ValueNotifier<int>(22);

  // 直接获取 android 数据
  final ValueNotifier<int> getAndroidNum = ValueNotifier<int>(22);

  @override
  void initState() {
    super.initState();
  }

  void initChannel(int viewId) {
    print('initChannel viewId: $viewId');

    mChannel = MethodChannel("$mChannelName/${viewId}");
    mChannel.setMethodCallHandler(callHandler);
  }

  /// 监听来自 Android端 的消息通道
  /// Android端调用了函数，这个handler函数就会被触发
  Future<dynamic> callHandler(MethodCall call) async {
    // 获取调用函数的名称
    final String methodName = call.method;
    dynamic arguments = call.arguments;

    debugPrint('callHandler methodName: ${methodName}  arguments: $arguments');

    switch (methodName) {
      case ANDROID_TO_FLUTTER:
        {
          int androidCount = call.arguments['androidNum'];
          fromAndroid.value = androidCount;
          return '$ANDROID_TO_FLUTTER ---> success';
        }
      case ANDROID_GET_FLUTTER:
        {
          return curNumFlutter.value ?? 0;
        }
    }
  }

  Future<void> sendMessageToApp(String json) async {
    try {
      await mChannel.invokeMethod('sendMessage', json);
    } catch (e) {
      debugPrint('e:${e}');
    }
  }

  /// Flutter端 向 Android端 发送数据，PUT 操作
  flutterSendAndroidData() {
    Map<String, dynamic> map = {
      'flutterNum': curNumFlutter.value,
      'zzz': 100,
      'flutter': 'flutter Name',
      'android': 'Android params',
    };
    mChannel
        .invokeMethod(FLUTTER_TO_ANDROID, map)
        .then((value) {
          debugPrint('$FLUTTER_TO_ANDROID --- Result：$value');
        })
        .catchError((e) {
          debugPrint('$FLUTTER_TO_ANDROID --- Error：$e');
        });
  }

  ///  Flutter端 获取 Android端 数据，GET 操作
  flutterGetAndroidData() {
    mChannel
        .invokeMethod(FLUTTER_GET_ANDROID)
        .then((value) {
          debugPrint('$FLUTTER_GET_ANDROID --- Result：$value');
          getAndroidNum.value = value ?? 0;
        })
        .catchError((e) {
          debugPrint('$FLUTTER_GET_ANDROID --- Error：$e');
        });
  }

  /// 累计点击次数
  computeCount() {
    curNumFlutter.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA4D3EE),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: AndroidView(
                  viewType: viewType,
                  // Android原生View 在Flutter引擎上注册的唯一标识，在Flutter端使用时必须一样
                  creationParams: {'flutterNum': curNumFlutter.value},
                  // Flutter端 初始化时 向Android端 传递的参数
                  creationParamsCodec: const StandardMessageCodec(),
                  // 消息编解码器
                  onPlatformViewCreated: (viewId) {
                    initChannel(viewId);
                  },
                ),
              ),
              Expanded(flex: 1, child: computeWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget computeWidget() {
    final ButtonStyle btnStyle = ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter页面',
              style: TextStyle(
                color: Color(0xff0066ff),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Row(
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: curNumFlutter,
                    builder: (context, count, _) {
                      return Text(
                        '点击次数：$count',
                        style: const TextStyle(fontSize: 16),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: ElevatedButton(
                      style: btnStyle,
                      onPressed: computeCount,
                      child: const Text('+1'),
                    ),
                  ),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: flutterSendAndroidData,
                    child: const Text('发送给Android端'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: getAndroidNum,
                      builder: (context, count, _) {
                        return Text(
                          '获取Android页面点击次数：$count',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 3),
                    child: ElevatedButton(
                      style: btnStyle,
                      onPressed: flutterGetAndroidData,
                      child: const Text('获取Android端数据'),
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: fromAndroid,
              builder: (context, count, _) {
                return Text(
                  '接收Android端发送的点击次数：$count',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 20.0, color: Colors.red),
              decoration: InputDecoration(
                hintText: "输入字符，自动发",
                contentPadding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                ),
              ),
              onChanged: (text) {
                debugPrint('输入字符：${text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
