import 'package:flutter/material.dart';
import '../common.dart';
import '../flukit/log_panel.dart';

/// 一个通用的页面容器组件，集成了 AppBar、内容内边距以及日志面板。
class PageScaffold extends StatefulWidget {
  const PageScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.padding = false, // 是否在内容四周添加默认内边距
    this.showLog = false, // 是否默认显示日志面板
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool padding;
  final bool showLog;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  late bool _showLog;

  @override
  void initState() {
    _showLog = widget.showLog;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageScaffold oldWidget) {
    if (oldWidget.showLog != widget.showLog) {
      _showLog = widget.showLog;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // 点击按钮切换日志面板的显示状态
          IconButton(
            onPressed: () {
              setState(() {
                _showLog = !_showLog;
              });
            },
            icon: const Icon(Icons.print),
          ),
        ],
      ),
      body: SafeArea(
        // VerticalLogPanel 是一个可以显示/隐藏日志区域的包装组件
        child: VerticalLogPanel(showLogPanel: _showLog, child: wBody()),
      ),
    );
  }

  /// 根据 padding 参数决定是否包裹一层 Padding 
  wBody() {
    return widget.padding
        ? Padding(padding: const EdgeInsets.all(16.0), child: widget.body)
        : widget.body;
  }
}

/// 页面描述类，用于封装页面的基本信息和跳转逻辑。
class ZPage {
  ZPage(
    this.title,
    Widget child, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  }) : builder = ((_) => child);

  /// 支持使用 builder 方式构建页面，延迟实例化组件
  ZPage.builder(
    this.title,
    this.builder, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  });

  String title; // 页面标题
  WidgetBuilder builder; // 构建页面内容的函数
  bool withScaffold; // 是否使用 PageScaffold 包裹
  bool padding; // PageScaffold 是否开启内边距
  bool showLog; // 是否开启日志面板

  /// 跳转并打开该页面
  Future<T?> openPage<T>(BuildContext context) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) {
          Widget widget = builder(context);
          if (withScaffold) {
            // 如果需要 Scaffold，则自动包裹 PageScaffold
            widget = PageScaffold(
              title: title,
              padding: padding,
              showLog: showLog,
              body: widget,
            );
          } else if (showLog) {
            // 如果不需要 Scaffold 但需要日志，则单独包裹日志面板
            widget = VerticalLogPanel(child: widget);
          }
          // 全局包裹日志监听作用域，用于捕获和显示 logEmitter 发出的日志
          return LogListenerScope(child: widget, logEmitter: logEmitter);
        },
      ),
    );
  }
}

/// 列表页面组件，接收一组 Page 对象并渲染成一个可点击跳转的 ListView。
class ListPage extends StatelessWidget {
  const ListPage({Key? key, required this.children}) : super(key: key);

  final List<ZPage> children;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _generateItem(context));
  }

  /// 将 Page 对象映射为 ListTile
  List<Widget> _generateItem(BuildContext context) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openPage(context),
      );
    }).toList();
  }
}
