import 'package:flutter/material.dart';
import '../common.dart';

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print('打印 LayoutBuilder 获取的信息: $constraints');

        if (constraints.maxWidth < 200) {
          return Column(mainAxisSize: MainAxisSize.min, children: children);
        } else {
          var _children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [children[i], children[i + 1]],
                ),
              );
            } else {
              _children.add(children[i]);
            }
          }
          return Column(mainAxisSize: MainAxisSize.min, children: _children);
        }
      },
    );
  }
}

/// 条件 A：宽度 < 200, 返回 Column（所有子元素垂直排列）。
/// 条件 B：宽度 >= 200, 返回“双排布局”。它会把子元素每两个一组放入 Row 中，然后再放进 Column。
class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return LayoutLogPrint(child:Text("xx"*20000));
    var children = List.filled(6, const Text("A"));
    var children2 = List.filled(6, const Text("B"));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 190, child: ResponsiveColumn(children: children)),
        ResponsiveColumn(children: children2),
        const LayoutLogPrint(tag: "排查按钮宽度", child: Text("flutter@wendux")),
        LayoutBuilder(builder: (context, constraints) {
          return LayoutLogPrint(
            tag: "排查按钮宽度",
            child: ElevatedButton(
              onPressed: () {
                // 这里通过外部包裹的 LayoutBuilder 拿到真实的约束信息
                print("排查按钮宽度点击输出: $constraints");
              },
              child: const Text("点我"),
            ),
          );
        }),
      ],
    );
  }
}
