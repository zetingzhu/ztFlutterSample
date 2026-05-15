import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zt_flutter_sample_v2/chapter2/2.3/TapboxA.dart';
import 'package:zt_flutter_sample_v2/chapter2/2.3/TapboxB.dart';
import 'package:zt_flutter_sample_v2/chapter2/2.3/TapboxC.dart';
import 'package:zt_flutter_sample_v2/chapter4/row.dart';
import 'package:zt_flutter_sample_v2/chapter4/colum2.dart';
import 'package:zt_flutter_sample_v2/chapter4/colum3.dart';
import 'package:zt_flutter_sample_v2/chapter6/ScrollControllerV1.dart';
import 'package:zt_flutter_sample_v2/chapter6/gridviewV1.dart';
import 'package:zt_flutter_sample_v2/chapter6/gridviewV2.dart';
import 'package:zt_flutter_sample_v2/chapter6/gridviewV4.dart';
import 'package:zt_flutter_sample_v2/chapter6/listviewV2.dart';
import 'package:zt_flutter_sample_v2/chapter6/listviewV3.dart';
import 'package:zt_flutter_sample_v2/chapter6/listviewV4.dart';
import 'package:zt_flutter_sample_v2/chapter6/pageviewV2.dart';
import 'package:zt_flutter_sample_v2/chapter6/pageviewV3.dart';
import 'package:zt_flutter_sample_v2/chapter6/pageviewV4.dart';
import 'package:zt_flutter_sample_v2/chapter7/BarBackCall.dart';
import 'package:zt_flutter_sample_v2/chapter8/notificationV2.dart';
import 'package:zt_flutter_sample_v2/v5/ShowAndroidV2.dart';
import 'package:zt_flutter_sample_v2/v5/CameraApp.dart';
import 'package:zt_flutter_sample_v2/v5/ImagePicker.dart';
import 'package:zt_flutter_sample_v2/v5/LanguageUtil.dart';
import 'package:zt_flutter_sample_v2/v5/ShowAndroidV3.dart';
import 'package:zt_flutter_sample_v2/v5/ShowAndroidV1.dart';
import 'package:zt_flutter_sample_v2/v5/ShowAndroidV4.dart';
import 'package:zt_flutter_sample_v2/v5/ThemeRoute.dart';
import 'package:zt_flutter_sample_v2/v6/CircleListItem.dart';
import 'package:zt_flutter_sample_v2/v6/CustomScrollViewV1.dart';
import 'package:zt_flutter_sample_v2/v6/CustomScrollViewV2.dart';
import 'package:zt_flutter_sample_v2/v6/SubscribeBtn.dart';
import 'package:zt_flutter_sample_v2/v5/ThemeRoute.dart';
import 'chapter11/weather_example.dart';
import 'chapter4/FlexLayoutTestRoute.dart';
import 'chapter4/colum.dart';
import 'chapter6/gridviewV3.dart';
import 'chapter9/scale_animation_listener.dart';
import 'routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _generateItem(BuildContext context, List<ZPage> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(
          page.title,
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openPage(context),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: const Text("2.第一个Flutter应用"),
            children: _generateItem(context, [
              ZPage("计数器", const CounterRoute(), withScaffold: false),
              ZPage("路由传值", const RouterTestRoute()),
              ZPage("State生命周期", const StateLifecycleTest()),
              ZPage(
                "子树中获取State对象",
                const GetStateObjectRoute(),
                withScaffold: false,
              ),
              ZPage(
                "Cupertino Demo",
                const CupertinoTestRoute(),
                withScaffold: true,
              ),
              ZPage("2.3 Widget管理自身状态", TapboxA()),
              ZPage("2.3 父Widget管理子Widget的状态", ParentWidget()),
              ZPage("2.3 混合状态管理", ParentWidgetC()),
            ]),
          ),
          ExpansionTile(
            title: const Text("3.基础组件"),
            children: _generateItem(context, [
              // PageInfo("Context测试",  ContextRoute(), withScaffold: false),
              // PageInfo("Widget树中获取State对象",  RetrieveStateRoute(), withScaffold: false),
              ZPage("文本、字体样式", const TextRoute()),
              ZPage("按钮", const ButtonRoute()),
              ZPage("图片伸缩", const ImageAndIconRoute()),
              ZPage("ICON fonts", const IconFontsRoute()),
              ZPage("单选开关和复选框", const SwitchAndCheckBoxRoute()),
              ZPage("输入框", const FocusTestRoute(), showLog: false),
              ZPage("Form", const FormTestRoute(), showLog: false),
              ZPage("进度条", const ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("4.布局类组件"),
            children: _generateItem(context, [
              ZPage("约束", const SizeConstraintsRoute(), withScaffold: false),
              ZPage("Row 布局", const RowLayout()),
              ZPage("Colum 布局", const ColumLayout()),
              ZPage("Colum 特殊情况，多层嵌套", const RowLayout2(), withScaffold: false),
              ZPage(
                "Colum 特殊情况，多层嵌套，占据全屏",
                const RowLayout3(),
                withScaffold: false,
              ),
              ZPage("Column居中", const CenterColumnRoute()),
              ZPage("弹性布局 Flex", const FlexLayoutTestRoute()),
              ZPage("流式布局 WrapAndFlow", const WrapAndFlowRoute()),
              ZPage("层叠布局 Stack Positioned ", const StackRoute()),
              ZPage("对齐及相对定位 Align", const AlignRoute()),
              ZPage("LayoutBuilder", const LayoutBuilderRoute(), padding: false),
              ZPage(
                "AfterLayout 它允许你在组件布局完成并渲染出第一帧后，安全地获取子组件的实际尺寸（Size）或位置（Offset），而不会触发布局阶段的重绘冲突",
                const AfterLayoutRoute(),
              ),
              ZPage("表格布局", const TableRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("5.容器类组件"),
            children: _generateItem(context, [
              ZPage("Padding： 专门给子组件四周“留白”，控制间距。", const PaddingTestRoute()),
              ZPage(
                "DecoratedBox： 用于给子组件绘制背景、边框、阴影等装饰。",
                const DecoratedBoxRoute(),
              ),
              ZPage(
                "Transform： 在绘制前对子组件进行旋转、缩放、平移等变换。RotatedBox: 负责“布局旋转”，旋转后会改变子组件占用的实际空间（如宽变高）。",
                const TransformRoute(),
              ),
              ZPage("Container 是一个极其常用的“全能型”组件", const ContainerRoute()),
              ZPage("Clip： 裁剪组件，用于实现圆角图片、圆形头像或溢出隐藏。", const ClipRoute()),
              ZPage(
                "FittedBox： 缩放适配，确保子组件按比例缩放以适应父容器大小。",
                const FittedBoxRoute(),
              ),
              ZPage(
                "Scaffold、TabBar、底部导航",
                const ScaffoldRoute(),
                withScaffold: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("6.可滚动组件"),
            children: _generateItem(context, [
              ZPage(
                "SingleChildScrollView",
                const SingleChildScrollViewTestRoute(),
                padding: false,
              ),
              ZPage("ListViewV2 普通列表", const ListViewV2(), padding: false),
              ZPage("ListViewV3 列表分割线", const ListViewV3(), padding: false),
              ZPage(
                "ListView 列表项固定高度列表（没看懂有啥用）",
                const FixedExtentList(),
                padding: false,
              ),
              ZPage("ListView 无限加载列表", const InfiniteListView(), padding: false),
              ZPage("ListViewV4 添加表头", const ListViewV4(), padding: false),
              ZPage(
                "ScrollControllerV1 监听滚动（判断当前位置是否超过1000像素，如果超过则在屏幕右下角显示一个“返回顶部”的按钮）",
                const ScrollControllerV1(),
                withScaffold: false,
                padding: false,
              ),
              ZPage("滚动监听", const ScrollNotificationTestRoute(), padding: false),
              ZPage("可滚动组件的通用配置", const ScrollViewConfiguration()),
              ZPage(
                "AnimatedList 可添加删除的列表",
                const AnimatedListRoute(),
                padding: false,
              ),
              ZPage(
                "InfiniteGridView",
                const InfiniteGridView(),
                padding: false,
              ),
              ZPage(
                "GridView SliverGridDelegateWithFixedCrossAxisCount ",
                const GridviewV1(),
                padding: false,
              ),
              ZPage(
                "GridView SliverGridDelegateWithMaxCrossAxisExtent ",
                const GridviewV2(),
                padding: false,
              ),
              ZPage(
                "GridView SliverGridDelegateWithFixedCrossAxisCount 等价 ",
                const GridviewV3(),
                padding: false,
              ),
              ZPage(
                "GridView SliverGridDelegateWithMaxCrossAxisExtent 等价 ",
                const GridviewV4(),
                padding: false,
              ),
              ZPage("PageView", const PageViewTest(), padding: false),
              ZPage("PageView V2", const PageViewV2(), padding: false),
              ZPage("PageView 缓存页面", const PageViewV3(), padding: false),
              ZPage("KeepAlive Test", const KeepAliveTest(), padding: false),
              ZPage("TabBarView", const TabViewRoute()),
              ZPage("Tab PageView 联动", const PageViewV4()),
              ZPage(
                "CustomScrollView",
                const CustomScrollViewTestRoute(),
                padding: false,
                showLog: false,
              ),
              ZPage(
                "PersistentHeaderRoute",
                const PersistentHeaderRoute(),
                padding: false,
                showLog: false,
              ),
              ZPage(
                "SliverFlexibleHeader",
                const SliverFlexibleHeaderRoute(),
                padding: false,
              ),
              ZPage(
                "SliverPersistentHeaderToBox",
                const SliverPersistentHeaderToBoxRoute(),
                padding: false,
              ),
              ZPage(
                "NestedScrollView",
                const NestedScrollViewRoute(),
                padding: false,
              ),
              ZPage("PullRefresh", const PullRefreshTestRoute(), padding: false),
              ZPage(
                "CustomPullRefresh",
                const PullRefreshBoxRoute(),
                padding: false,
              ),
              //PageInfo("pullrefresh",  PullRefreshRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("7.功能性组件"),
            children: _generateItem(context, [
              ZPage("导航返回拦截", const WillPopScopeTestRoute()),
              ZPage("导航返回拦截 2", const BackPopScope(), withScaffold: false),
              ZPage("数据共享(inheritedWidget)", const InheritedWidgetTestRoute()),
              ZPage("跨组件状态管理(Provider)", const ProviderRoute()),
              ZPage("颜色和MaterialColor", const ColorRoute(), withScaffold: false),
              ZPage("主题-Theme", const ThemeTestRoute(), withScaffold: false),
              ZPage(
                "ValueListenableBuilder",
                const ValueListenableRoute(),
                withScaffold: false,
              ),
              ZPage("FutureBuilder", const FutureAndStreamBuilderRoute()),
              ZPage("StreamBuilder", const StreamBuilderRoute()),
              ZPage("对话框", const DialogTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("8.事件处理与通知"),
            children: _generateItem(context, [
              ZPage("原生指针事件", const PointerRoute(), padding: false),
              ZPage("手势识别", const GestureRoute(), padding: false),
              ZPage(
                "Stack 点击测试",
                const StackEventTest(),
                padding: false,
                showLog: false,
              ),
              ZPage("事件冲突", const EventConflictTest()),
              ZPage("通知(Notification) 自定义通知", const NotificationRoute()),
              ZPage("通知(Notification) V2", const NotificationV2()),
              ZPage("PointerDownListener", const PointerDownListenerRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("9.动画"),
            children: _generateItem(context, [
              ZPage("放大动画-原始版", const ScaleAnimationRoute()),
              ZPage("放大动画-AnimatedWidget版", const ScaleAnimationRoute1()),
              ZPage("放大动画-AnimatedBuilder版", const ScaleAnimationRoute2()),
              ZPage("放大动画-GrowTransition版", const GrowTransitionRoute()),
              ZPage("放大动画-动画监听", const ScaleAnimationRoute3()),
              ZPage("Hero动画", const HeroAnimationRoute(), padding: false),
              ZPage("交织动画(Stagger Animation)", const StaggerRoute()),
              ZPage(
                "动画切换组件(AnimatedSwitcher)",
                const AnimatedSwitcherCounterRoute(),
              ),
              ZPage("动画切换组件高级用法", const AnimatedSwitcherRoute()),
              ZPage("动画过渡组件", const AnimatedWidgetsTest()),
            ]),
          ),
          ExpansionTile(
            title: const Text("10.自定义组件"),
            children: _generateItem(context, [
              ZPage("GradientButton", const GradientButtonRoute()),
              ZPage("旋转容器：TurnBox", const TurnBoxRoute()),
              ZPage("CustomPaint", const CustomPaintRoute()),
              ZPage("自绘控件：圆形渐变进度条", const GradientCircularProgressRoute()),
              ZPage("自绘带动画控件：CustomCheckBox", const CustomCheckboxTest()),
              ZPage("自绘带动画控件：DoneWidget", const DoneWidgetTestRoute()),
              ZPage(
                "水印",
                const WatermarkRoute(),
                padding: false,
                showLog: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("11.文件与网络"),
            children: _generateItem(context, [
              ZPage("文件操作", FileOperationRoute(), withScaffold: false),
              ZPage("Http请求", HttpTestRoute()),
              ZPage("WebSocket", WebSocketRoute(), withScaffold: false),
              ZPage("Socket", const SocketRoute()),
              ZPage("测试网络请求工具", const SocketRoute()),
              ZPage("测试网络请求高德天气", WeatherExample(), withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: const Text("其它"),
            children: _generateItem(context, [
              ZPage(
                "WebView",
                const WebViewTest(),
                padding: false,
                withScaffold: false,
                //showLog: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("Flutter原理"),
            children: _generateItem(context, [
              ZPage("图片加载原理与缓存", ImageInternalTestRoute()),
              ZPage("CustomCenter", const MyCenterRoute()),
              ZPage("LeftRightBox", const LeftRightBoxTestRoute()),
              ZPage("约束详解", const ConstraintsTest(), withScaffold: false),
              ZPage("AccurateSizedBox", const AccurateSizedBoxRoute()),
              ZPage("StateChangeTest", const StateChangeTest()),
              ZPage("RepaintBoundary", const RepaintBoundaryTest()),
              ZPage("CompositingBits Test", const CustomRotatedBoxTest()),
              ZPage("Paint原理", const PaintTest()),
            ]),
          ),
          ExpansionTile(
            title: Text("包与插件"),
            children: _generateItem(context, [
              ZPage("Camera 相机", const CameraApp(), withScaffold: false),
              ZPage(
                "image_picker 图片文件选择器",
                const ImagePickerSample(title: "Image Picker Demo"),
                withScaffold: false,
              ),
              ZPage("国际化切换", LanguageSetting(), withScaffold: false),
              ZPage("调用 Android 原生 1", ShowAndroidUi(), withScaffold: false),
              ZPage("调用 Android 原生 2", BatteryRoute(), withScaffold: false),
              ZPage("调用 Android 原生 4", ShowAndroidV4(), withScaffold: false),
              ZPage("调用 Android 原生 3", SendMessageState(), withScaffold: false),
              ZPage("切换主题", ThemeRoute(), withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: Text("应用示例"),
            children: _generateItem(context, [
              ZPage(
                "制造闪烁加载效果",
                const ExampleUiLoadingAnimation(),
                withScaffold: false,
              ),
              ZPage(
                "在列表上方放置一个浮动应用栏1",
                const CustomScrollViewV1(),
                withScaffold: false,
              ),
              ZPage(
                "在列表上方放置一个浮动应用栏2",
                const CustomScrollViewV2(),
                withScaffold: false,
              ),
              ZPage("订阅按钮状态，失败恢复状态", const SubscribeBtn(), withScaffold: false),
              Page("国际化切换", LanguageSetting(), withScaffold: false),
              Page("调用 Android 原生 1", ShowAndroidUi(), withScaffold: false),
              Page("调用 Android 原生 2", BatteryRoute(), withScaffold: false),
              Page("调用 Android 原生 4", ShowAndroidV4(), withScaffold: false),
              Page("调用 Android 原生 3", SendMessageState(), withScaffold: false),
              Page("切换主题", ThemeRoute(), withScaffold: false),
            ]),
          ),
        ],
      ),
    );
  }
}
