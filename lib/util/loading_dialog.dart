import 'package:flutter/material.dart';

class LoadingDialog {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// 显示加载弹框
  static void show(
    BuildContext context, {
    String message = '正在加载...',
    Color backgroundColor = Colors.black54,
    Color indicatorColor = Colors.blue,
    Color textColor = Colors.black87,
  }) {
    if (_isShowing) return;

    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: backgroundColor,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                ),
                const SizedBox(height: 16),
                Text(message, style: TextStyle(fontSize: 16, color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// 隐藏加载弹框
  static void hide() {
    if (!_isShowing) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  /// 显示带有自定义消息的加载弹框
  static void showWithMessage(BuildContext context, String message) {
    show(context, message: message);
  }

  /// 检查是否正在显示
  static bool get isShowing => _isShowing;
}
