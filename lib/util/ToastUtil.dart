import 'dart:async';
import 'package:flutter/material.dart';

class ToastUtil {
  static final ToastUtil _instance = ToastUtil._internal();

  factory ToastUtil() => _instance;

  ToastUtil._internal();

  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;
  static Timer? _timer;

  void showToast(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black54,
    Color textColor = Colors.white,
    double radius = 10.0,
  }) {
    if (_isShowing) {
      // 如果正在显示，先移除旧的 Toast
      _timer?.cancel();
      _overlayEntry?.remove();
      _isShowing = false;
    }

    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        // 将 Toast 放置在屏幕中间
        top: MediaQuery.of(context).size.height * 0.7,
        // width: MediaQuery.of(context).size.width,
        left: 16.0, // 距离左边 16 像素
        right: 16.0, // 距离右边 16 像素
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Text(
                message,
                style: TextStyle(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    // 将 OverlayEntry 插入到 Overlay 中
    Overlay.of(context).insert(_overlayEntry!);

    // 设置定时器，在指定时间后移除 Toast
    _timer = Timer(duration, () {
      if (_isShowing) {
        _overlayEntry?.remove();
        _isShowing = false;
        _overlayEntry = null;
      }
    });
  }
}
