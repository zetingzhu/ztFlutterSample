import 'package:flutter/material.dart';

/// 自定义TabBar指示器，可以设置固定宽度
class CustomTabIndicator extends Decoration {
  final double width;
  final Color color;
  final double height;

  const CustomTabIndicator({
    required this.width,
    required this.color,
    this.height = 3.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      width: width,
      color: color,
      height: height,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final double width;
  final Color color;
  final double height;

  _CustomPainter({
    required this.width,
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    
    // 计算指示器的位置，使其居中
    final double indicatorLeft = rect.left + (rect.width - width) / 2;
    final double indicatorRight = indicatorLeft + width;
    final double indicatorTop = rect.bottom - height;
    
    canvas.drawRect(
      Rect.fromLTRB(indicatorLeft, indicatorTop, indicatorRight, rect.bottom),
      paint,
    );
  }
}