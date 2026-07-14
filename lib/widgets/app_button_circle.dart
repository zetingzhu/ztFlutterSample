import 'package:flutter/material.dart';

class AppButtonCircle extends StatelessWidget {
  const AppButtonCircle({super.key,
    required this.size,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final double size;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.12),
          //     blurRadius: 6,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.45),
      ),
    );
  }
}
