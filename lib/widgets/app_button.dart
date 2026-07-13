import 'package:flutter/material.dart';

/// 公共按钮。
///
/// ```dart
/// AppButton.submit(text: '确定', fontSize: 16, onPressed: () {});
/// AppButton.cancel(text: '取消', fontSize: 15, onPressed: () {});
/// ```
class AppButton extends StatelessWidget {
  /// 提交按钮：蓝底白字、无阴影。
  const AppButton.submit({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.onPressed,
    this.width,
    this.height = 44,
    this.backgroundColor = const Color(0xFF1676FE),
    this.textColor = Colors.white,
    this.borderRadius = 22,
    this.fontWeight = FontWeight.w500,
  });

  /// 取消按钮：灰色文字、透明背景。
  const AppButton.cancel({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.onPressed,
    this.width,
    this.height = 44,
    this.backgroundColor = Colors.transparent,
    this.textColor = const Color(0xFF878E9C),
    this.borderRadius = 0,
    this.fontWeight = FontWeight.normal,
  });

  /// 按钮文字。
  final String text;

  /// 字体大小。
  final double fontSize;

  /// 点击回调；为 `null` 时按钮禁用。
  final VoidCallback? onPressed;

  /// 按钮宽度；默认撑满父布局。
  final double? width;

  /// 按钮高度。
  final double height;

  /// 背景色。
  final Color backgroundColor;

  /// 文字颜色。
  final Color textColor;

  /// 圆角半径。
  final double borderRadius;

  /// 字体粗细。
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor == Colors.transparent
              ? null
              : backgroundColor.withValues(alpha: 0.5),
          foregroundColor: textColor,
          disabledForegroundColor: textColor.withValues(alpha: 0.5),
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: borderRadius > 0
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
