import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'extra_info_constraints.dart';

typedef SliverPersistentHeaderToBoxBuilder =
    Widget Function(
      BuildContext context,
      double maxExtent, //当前可用最大高度
      bool fixed, // 是否已经固定
    );

class SliverPersistentHeaderToBox extends StatelessWidget {
  // 默认构造函数，直接接受一个 widget，不用显式指定高度
  SliverPersistentHeaderToBox({Key? key, required Widget child})
    : builder = ((a, b, c) => child),
      super(key: key);

  // builder 构造函数，需要传一个 builder，同样不需要显式指定高度
  SliverPersistentHeaderToBox.builder({Key? key, required this.builder})
    : super(key: key);

  final SliverPersistentHeaderToBoxBuilder builder;

  @override
  Widget build(BuildContext context) {
    return _SliverPersistentHeaderToBox(
      // 通过 LayoutBuilder接收 Sliver 传递给子组件的布局约束信息
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return builder(
            context,
            constraints.maxHeight,

            //约束中需要传递的额外信息是一个bool类型，表示 Sliver 是否已经固定到顶部
            (constraints as ExtraInfoBoxConstraints<bool>).extra,
          );
        },
      ),
    );
  }
}

class _SliverPersistentHeaderToBox extends SingleChildRenderObjectWidget {
  const _SliverPersistentHeaderToBox({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverPersistentHeaderToBox();
  }
}

class _RenderSliverPersistentHeaderToBox extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child!.layout(
      ExtraInfoBoxConstraints(
        // 只要constraints.scrollOffset不为0，则表示已经有内容在当前Sliver下面了（重叠了）
        constraints.scrollOffset != .0,
        constraints.asBoxConstraints(
          // 我们将剩余的可绘制空间作为 header 的最大高度约束传递给 LayoutBuilder
          maxExtent: constraints.remainingPaintExtent,
        ),
      ),
      //我们要根据child大小来确定Sliver大小，所以后面需要用到child的size信息
      parentUsesSize: true,
    );

    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintOrigin: 0, // 固定，如果不想固定应该传 - constraints.scrollOffset
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
    );
  }

  // 重要，如果没有重写则不会响应事件，点击测试中会用到。关于点击测试我们会在本书面介绍,
  // 读者现在只需要知道该函数应该返回 paintOrigin 的位置即可。
  @override
  double childMainAxisPosition(RenderBox child) => 0.0;
}
