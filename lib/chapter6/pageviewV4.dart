import 'dart:ui';

import 'package:flutter/material.dart';
import '../routes.dart';
import 'dart:math' as math;

class PageViewV4 extends StatefulWidget {
  const PageViewV4({super.key});

  @override
  _PageViewTestState createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewV4> {
  // 页面控制器
  late PageController pageController;

  // 当前页面索引
  int currentPage = 0;

  // 标签文本列表
  final List<String> tabs = ['首页', '消息', '联系人', '设置', '我的'];

  @override
  void initState() {
    super.initState();
    // 初始化页面控制器
    pageController = PageController(initialPage: currentPage);
    // 添加页面变化监听
    pageController.addListener(_onPageChange);
  }

  @override
  void dispose() {
    // 移除监听并释放控制器
    pageController.removeListener(_onPageChange);
    pageController.dispose();
    super.dispose();
  }

  // 页面变化监听函数
  void _onPageChange() {
    final int newPage = pageController.page?.round() ?? 0;
    if (newPage != currentPage) {
      setState(() {
        currentPage = newPage;
      });
    }
  }

  // 切换到指定页面
  void _goToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 自定义Tab栏
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: List.generate(tabs.length, (index) {
              // 判断是否为当前选中的tab
              final bool isSelected = index == currentPage;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _goToPage(index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: isSelected ? Colors.blue : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black54,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // PageView部分
        Expanded(
          child: PageView(
            controller: pageController,
            children: tabs.map((text) => TabPage(text: text)).toList(),
          ),
        ),
      ],
    );
  }
}

// Tab 页面
class TabPage extends StatefulWidget {
  const TabPage({super.key, required this.text});

  final String text;

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("build ${widget.text}");
    return Center(child: Text(widget.text, textScaler: TextScaler.linear(5)));
  }

  @override
  bool get wantKeepAlive => true;
}
