import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowAndroidUi extends StatefulWidget {
  const ShowAndroidUi({Key? key}) : super(key: key);

  @override
  State<ShowAndroidUi> createState() => _ShowAndroidUiState();
}

class _ShowAndroidUiState extends State<ShowAndroidUi> {
  static const platform = MethodChannel('com.example.android_ui_channel');
  String _message = '等待 Android UI 交互...';

  @override
  void initState() {
    super.initState();
    _setupMethodChannel();
  }

  void _setupMethodChannel() {
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onButtonClicked':
          setState(() {
            _message = 'Android 按钮被点击了！数据: ${call.arguments}';
          });
          break;
        case 'onTextChanged':
          setState(() {
            _message = 'Android 文本改变: ${call.arguments}';
          });
          break;
        default:
          throw MissingPluginException('未实现的方法: ${call.method}');
      }
    });
  }

  Future<void> _sendDataToAndroid() async {
    try {
      await platform.invokeMethod('sendDataToAndroid', {
        'message': 'Hello from Flutter!',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } on PlatformException catch (e) {
      print('发送数据到 Android 失败: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 嵌入 Android UI'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 嵌入的 Android UI 部分
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const AndroidView(
                viewType: 'android_custom_view',
                creationParams: <String, dynamic>{
                  'title': 'Android 原生 UI',
                  'backgroundColor': 0xFF4CAF50,
                },
                creationParamsCodec: StandardMessageCodec(),
              ),
            ),
          ),
          // Flutter UI 部分
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Column(
                children: [
                  const Text(
                    'Flutter UI 区域',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _message,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sendDataToAndroid,
                    child: const Text('发送数据到 Android'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
