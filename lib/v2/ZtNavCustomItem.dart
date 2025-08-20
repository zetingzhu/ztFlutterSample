import 'package:flutter/material.dart';

/// 自定义的顶部导航栏
class ZtNavCustomItem extends StatelessWidget {
  final IconData mIcon;
  final String label;
  final bool hasBadge;
  final bool isSelected;
  final VoidCallback? onTap; // 添加点击回调

  const ZtNavCustomItem({
    super.key,
    required this.mIcon,
    required this.label,
    this.hasBadge = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.red : Colors.blueAccent;

    return GestureDetector(
      onTap: onTap, // 添加点击处理
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Badge.count(
                count: 3,
                offset: const Offset(10, -10), // +: 向右，向下 ，-: 向上，向左
                child: Icon(mIcon, color: color),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(mIcon, color: color),
                  if (hasBadge)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              Badge(
                label: const Text('4'),
                child: Icon(mIcon, color: color),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
