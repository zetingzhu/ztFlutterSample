import 'package:flutter/material.dart';

import 'package:zt_flutter_sample_v2/v2/ZtNavCustomItem.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({
    super.key,
    this.onSelectItem,
    required this.selectedIndex,
  });

  final void Function(int)? onSelectItem;
  final int selectedIndex;

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  // 添加处理函数
  void clickSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelectItem!(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          selectedIndex = index;
        });
        widget.onSelectItem!(index);
      },
      destinations: barWithBadgeDestinations(selectedIndex, clickSelected),
    );
  }
}

List<Widget> barWithBadgeDestinations(int selectedIndex, Function(int) onTap) {
  return [
    NavigationDestination(
      tooltip: '',
      icon: Badge.count(count: 1000, child: const Icon(Icons.mail_outlined)),
      label: 'Mail',
      selectedIcon: Badge.count(count: 1000, child: const Icon(Icons.mail)),
    ),
    const NavigationDestination(
      tooltip: '',
      icon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble_outline)),
      label: 'Chat',
      selectedIcon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble)),
    ),
    const NavigationDestination(
      tooltip: '',
      icon: Badge(child: Icon(Icons.group_outlined)),
      label: 'Rooms',
      selectedIcon: Badge(child: Icon(Icons.group_rounded)),
    ),
    NavigationDestination(
      tooltip: '',
      icon: Badge.count(count: 3, child: const Icon(Icons.videocam_outlined)),
      label: 'Meet',
      selectedIcon: Badge.count(count: 3, child: const Icon(Icons.videocam)),
    ),
    ZtNavCustomItem(
      mIcon: Icons.settings,
      label: '设置',
      hasBadge: true,
      isSelected: selectedIndex == 4,
      onTap: () => onTap(4),
    ),
  ];
}
