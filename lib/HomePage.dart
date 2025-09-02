import 'package:flutter/material.dart' hide Page;
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
  List<Widget> _generateItem(BuildContext context, List<Page> children) {
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
              Page("计数器", const CounterRoute(), withScaffold: false),
              Page("路由传值", const RouterTestRoute()),
              Page("State生命周期", const StateLifecycleTest()),
              Page(
                "子树中获取State对象",
                const GetStateObjectRoute(),
                withScaffold: false,
              ),
              Page(
                "Cupertino Demo",
                const CupertinoTestRoute(),
                withScaffold: true,
              ),
              Page("2.3 Widget管理自身状态", TapboxA()),
              Page("2.3 父Widget管理子Widget的状态", ParentWidget()),
              Page("2.3 混合状态管理", ParentWidgetC()),
            ]),
          ),
          ExpansionTile(
            title: const Text("3.基础组件"),
            children: _generateItem(context, [
              // PageInfo("Context测试",  ContextRoute(), withScaffold: false),
              // PageInfo("Widget树中获取State对象",  RetrieveStateRoute(), withScaffold: false),
              Page("文本、字体样式", const TextRoute()),
              Page("按钮", const ButtonRoute()),
              Page("图片伸缩", const ImageAndIconRoute()),
              Page("ICON fonts", const IconFontsRoute()),
              Page("单选开关和复选框", const SwitchAndCheckBoxRoute()),
              Page("输入框", const FocusTestRoute(), showLog: false),
              Page("Form", const FormTestRoute(), showLog: false),
              Page("进度条", const ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("4.布局类组件"),
            children: _generateItem(context, [
              Page("约束", const SizeConstraintsRoute(), withScaffold: false),
              Page("Row 布局", const RowLayout()),
              Page("Colum 布局", const ColumLayout()),
              Page("Colum 特殊情况，多层嵌套", const RowLayout2(), withScaffold: false),
              Page(
                "Colum 特殊情况，多层嵌套，占据全屏",
                const RowLayout3(),
                withScaffold: false,
              ),
              Page("Column居中", const CenterColumnRoute()),
              Page("弹性布局 Flex", const FlexLayoutTestRoute()),
              Page("流式布局 WrapAndFlow", const WrapAndFlowRoute()),
              Page("层叠布局 Stack Positioned ", const StackRoute()),
              Page("对齐及相对定位 Align", const AlignRoute()),
              Page("LayoutBuilder", const LayoutBuilderRoute(), padding: false),
              Page("AfterLayout", const AfterLayoutRoute()),
              Page("表格布局", const TableRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("5.容器类组件"),
            children: _generateItem(context, [
              Page("填充Padding", const PaddingTestRoute()),
              Page("DecoratedBox", const DecoratedBoxRoute()),
              Page("变换 Transform 和 RotatedBox ", const TransformRoute()),
              Page("Container", const ContainerRoute()),
              Page("剪裁 Clip ", const ClipRoute()),
              Page("FittedBox", const FittedBoxRoute()),
              Page(
                "Scaffold、TabBar、底部导航",
                const ScaffoldRoute(),
                withScaffold: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("6.可滚动组件"),
            children: _generateItem(context, [
              Page(
                "SingleChildScrollView",
                const SingleChildScrollViewTestRoute(),
                padding: false,
              ),
              Page("ListViewV2 普通列表", const ListViewV2(), padding: false),
              Page("ListViewV3 列表分割线", const ListViewV3(), padding: false),
              Page(
                "ListView 列表项固定高度列表（没看懂有啥用）",
                const FixedExtentList(),
                padding: false,
              ),
              Page("ListView 无限加载列表", const InfiniteListView(), padding: false),
              Page("ListViewV4 添加表头", const ListViewV4(), padding: false),
              Page(
                "ScrollControllerV1 监听滚动（判断当前位置是否超过1000像素，如果超过则在屏幕右下角显示一个“返回顶部”的按钮）",
                const ScrollControllerV1(),
                withScaffold: false,
                padding: false,
              ),
              Page("滚动监听", const ScrollNotificationTestRoute(), padding: false),
              Page("可滚动组件的通用配置", const ScrollViewConfiguration()),
              Page(
                "AnimatedList 可添加删除的列表",
                const AnimatedListRoute(),
                padding: false,
              ),
              Page(
                "InfiniteGridView",
                const InfiniteGridView(),
                padding: false,
              ),
              Page(
                "GridView SliverGridDelegateWithFixedCrossAxisCount ",
                const GridviewV1(),
                padding: false,
              ),
              Page(
                "GridView SliverGridDelegateWithMaxCrossAxisExtent ",
                const GridviewV2(),
                padding: false,
              ),
              Page(
                "GridView SliverGridDelegateWithFixedCrossAxisCount 等价 ",
                const GridviewV3(),
                padding: false,
              ),
              Page(
                "GridView SliverGridDelegateWithMaxCrossAxisExtent 等价 ",
                const GridviewV4(),
                padding: false,
              ),
              Page("PageView", const PageViewTest(), padding: false),
              Page("PageView V2", const PageViewV2(), padding: false),
              Page("PageView 缓存页面", const PageViewV3(), padding: false),
              Page("KeepAlive Test", const KeepAliveTest(), padding: false),
              Page("TabBarView", const TabViewRoute()),
              Page("Tab PageView 联动", const PageViewV4()),
              Page(
                "CustomScrollView",
                const CustomScrollViewTestRoute(),
                padding: false,
                showLog: false,
              ),
              Page(
                "PersistentHeaderRoute",
                const PersistentHeaderRoute(),
                padding: false,
                showLog: false,
              ),
              Page(
                "SliverFlexibleHeader",
                const SliverFlexibleHeaderRoute(),
                padding: false,
              ),
              Page(
                "SliverPersistentHeaderToBox",
                const SliverPersistentHeaderToBoxRoute(),
                padding: false,
              ),
              Page(
                "NestedScrollView",
                const NestedScrollViewRoute(),
                padding: false,
              ),
              Page("PullRefresh", const PullRefreshTestRoute(), padding: false),
              Page(
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
              Page("导航返回拦截", const WillPopScopeTestRoute()),
              Page("导航返回拦截 2", const BackPopScope(), withScaffold: false),
              Page("数据共享(inheritedWidget)", const InheritedWidgetTestRoute()),
              Page("跨组件状态管理(Provider)", const ProviderRoute()),
              Page("颜色和MaterialColor", const ColorRoute(), withScaffold: false),
              Page("主题-Theme", const ThemeTestRoute(), withScaffold: false),
              Page(
                "ValueListenableBuilder",
                const ValueListenableRoute(),
                withScaffold: false,
              ),
              Page("FutureBuilder", const FutureAndStreamBuilderRoute()),
              Page("StreamBuilder", const StreamBuilderRoute()),
              Page("对话框", const DialogTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("8.事件处理与通知"),
            children: _generateItem(context, [
              Page("原生指针事件", const PointerRoute(), padding: false),
              Page("手势识别", const GestureRoute(), padding: false),
              Page(
                "Stack 点击测试",
                const StackEventTest(),
                padding: false,
                showLog: false,
              ),
              Page("事件冲突", const EventConflictTest()),
              Page("通知(Notification) 自定义通知", const NotificationRoute()),
              Page("通知(Notification) V2", const NotificationV2()),
              Page("PointerDownListener", const PointerDownListenerRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("9.动画"),
            children: _generateItem(context, [
              Page("放大动画-原始版", const ScaleAnimationRoute()),
              Page("放大动画-AnimatedWidget版", const ScaleAnimationRoute1()),
              Page("放大动画-AnimatedBuilder版", const ScaleAnimationRoute2()),
              Page("放大动画-GrowTransition版", const GrowTransitionRoute()),
              Page("放大动画-动画监听", const ScaleAnimationRoute3()),
              Page("Hero动画", const HeroAnimationRoute(), padding: false),
              Page("交织动画(Stagger Animation)", const StaggerRoute()),
              Page(
                "动画切换组件(AnimatedSwitcher)",
                const AnimatedSwitcherCounterRoute(),
              ),
              Page("动画切换组件高级用法", const AnimatedSwitcherRoute()),
              Page("动画过渡组件", const AnimatedWidgetsTest()),
            ]),
          ),
          ExpansionTile(
            title: const Text("10.自定义组件"),
            children: _generateItem(context, [
              Page("GradientButton", const GradientButtonRoute()),
              Page("旋转容器：TurnBox", const TurnBoxRoute()),
              Page("CustomPaint", const CustomPaintRoute()),
              Page("自绘控件：圆形渐变进度条", const GradientCircularProgressRoute()),
              Page("自绘带动画控件：CustomCheckBox", const CustomCheckboxTest()),
              Page("自绘带动画控件：DoneWidget", const DoneWidgetTestRoute()),
              Page(
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
              Page("文件操作", FileOperationRoute(), withScaffold: false),
              Page("Http请求", HttpTestRoute()),
              Page("WebSocket", WebSocketRoute(), withScaffold: false),
              Page("Socket", const SocketRoute()),
              Page("测试网络请求工具", const SocketRoute()),
              Page("测试网络请求高德天气", WeatherExample(), withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: const Text("其它"),
            children: _generateItem(context, [
              Page(
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
              Page("图片加载原理与缓存", ImageInternalTestRoute()),
              Page("CustomCenter", const MyCenterRoute()),
              Page("LeftRightBox", const LeftRightBoxTestRoute()),
              Page("约束详解", const ConstraintsTest(), withScaffold: false),
              Page("AccurateSizedBox", const AccurateSizedBoxRoute()),
              Page("StateChangeTest", const StateChangeTest()),
              Page("RepaintBoundary", const RepaintBoundaryTest()),
              Page("CompositingBits Test", const CustomRotatedBoxTest()),
              Page("Paint原理", const PaintTest()),
            ]),
          ),

          ExpansionTile(
            title: Text("包与插件"),
            children: _generateItem(context, [
              Page("Camera 相机", const CameraApp(), withScaffold: false),
              Page(
                "image_picker 图片文件选择器",
                const ImagePickerSample(title: "Image Picker Demo"),
                withScaffold: false,
              ),
              Page("国际化切换", LanguageSetting(), withScaffold: false),
              Page("调用 Android 原生 1", ShowAndroidUi(), withScaffold: false),
              Page("调用 Android 原生 2", BatteryRoute(), withScaffold: false),
              Page("调用 Android 原生 4", ShowAndroidV4(), withScaffold: false),
              Page("调用 Android 原生 3", SendMessageState(), withScaffold: false),
            ]),
          ),
        ],
      ),
    );
  }
}
