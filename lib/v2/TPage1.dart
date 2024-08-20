import 'package:flutter/material.dart';

class TPage1 extends StatelessWidget {
  const TPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("显示内容 1", style: textTheme.displaySmall),
    );
  }
}
