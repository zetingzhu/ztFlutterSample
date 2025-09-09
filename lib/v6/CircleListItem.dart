import 'package:flutter/material.dart';

// 定义微光（Shimmer）效果的渐变颜色、停止点和方向
const _shimmerGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

/// 演示微光加载动画的主页面
class ExampleUiLoadingAnimation extends StatefulWidget {
  const ExampleUiLoadingAnimation({super.key});

  @override
  State<ExampleUiLoadingAnimation> createState() =>
      _ExampleUiLoadingAnimationState();
}

class _ExampleUiLoadingAnimationState extends State<ExampleUiLoadingAnimation> {
  bool _isLoading = true; // 控制是否处于加载状态

  // 切换加载状态
  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        linearGradient: _shimmerGradient, // 传入全局渐变配置
        child: ListView(
          // 加载时禁用滚动，防止坐标计算出错
          physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
          children: [
            const SizedBox(height: 16),
            _buildTopRowList(),
            const SizedBox(height: 16),
            _buildListItem(),
            _buildListItem(),
            _buildListItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(_isLoading ? Icons.hourglass_full : Icons.hourglass_bottom),
      ),
    );
  }

  // 构建顶部水平滚动的圆形头像列表
  Widget _buildTopRowList() {
    return SizedBox(
      height: 72,
      child: ListView(
        physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 16),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
          _buildTopRowItem(),
        ],
      ),
    );
  }

  // 构建单个带加载效果的圆形头像
  Widget _buildTopRowItem() {
    return ShimmerLoading(isLoading: _isLoading, child: const CircleListItem());
  }

  // 构建单个带加载效果的卡片项
  Widget _buildListItem() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: CardListItem(isLoading: _isLoading),
    );
  }
}

/// 微光效果的容器组件，负责管理动画控制器
class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({super.key, required this.linearGradient, this.child});

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    // 创建一个无限循环的动画，控制渐变的移动偏移
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // 获取带当前动画偏移的渐变对象
  LinearGradient get gradient => LinearGradient(
    colors: widget.linearGradient.colors,
    stops: widget.linearGradient.stops,
    begin: widget.linearGradient.begin,
    end: widget.linearGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  // 计算子组件相对于 Shimmer 容器的偏移，以便渐变能跨组件连续
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

/// 渐变变换类，用于根据动画值平移渐变矩阵
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

/// 单个组件的加载包装器，根据是否加载中应用 ShaderMask 遮罩
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 监听父级 Shimmer 的动画变化
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // 动画每一帧都会重绘，产生流动效果
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child; // 非加载状态直接显示原组件
    }

    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      return const SizedBox(); // 父级未完成布局时返回空
    }
    
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    // 获取当前组件在 Shimmer 容器中的位置，用于对齐渐变
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        // 创建一个反向偏移的 Shader，使得所有子组件看起来是在共享同一个流动的背景渐变
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//----------- 内容组件：圆形头像 ---------
class CircleListItem extends StatelessWidget {
  const CircleListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.black, // 加载时显示黑色底色（被遮罩后变成灰色）
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.network(
            'https://docs.flutter.dev/assets/images/'
            'exercise/split-check/Avatar1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

//----------- 内容组件：图片文字卡片 ---------
class CardListItem extends StatelessWidget {
  const CardListItem({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImage(), const SizedBox(height: 16), _buildText()],
      ),
    );
  }

  // 构建图片部分
  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://docs.flutter.dev/assets/images/'
            'exercise/split-check/Food1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // 构建文字占位符（加载中）或真实文本
  Widget _buildText() {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 250,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
          'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      );
    }
  }
}
