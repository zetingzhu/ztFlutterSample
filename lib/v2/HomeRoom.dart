import 'package:flutter/material.dart';
import 'package:zt_flutter_sample_v2/widgets/page_scaffold.dart';

import '../chapter2/counter.dart';
import '../dialog/AlertDialog_sample.dart';
import '../dialog/Dialog_sample.dart';
import '../dialog/SimpleDialog_sample.dart';
import '../dialog/custom_dialog_sample.dart';
import '../dialog/custom_info_dialog.dart';
import '../dialog/partial_close_dialog.dart';

class HomeRoom extends StatefulWidget {
  const HomeRoom({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeRoomState();
  }
}

class _HomeRoomState extends State<HomeRoom> {
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

  Widget zPageItem(BuildContext context, ZPage children) {
    return ListTile(
      title: Text(children.title),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () => children.openPage(context),
    );
  }

  void _showActionTip(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
            ]),
          ),
          ListTile(title: Text('命名路由'), onTap: () => {}),
          zPageItem(context, ZPage("计数器", const CounterRoute())),
          ListTile(
            title: const Text('部分平仓弹框'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () async {
              await showPartialCloseDialog(context);
            },
          ),
          zPageItem(context, ZPage('Dialog', const DialogSample())),
          zPageItem(context, ZPage('AlertDialog', const AlertDialogSample())),
          zPageItem(context, ZPage('SimpleDialog', const SimpleDialogSample())),
          zPageItem(context, ZPage('自定义弹框', const CustomDialogSample())),
          ListTile(
            title: const Text('显示自定义弹框'),
            subtitle: const Text('onConfirm / onCancel / onClose'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              showCustomInfoDialog(
                context,
                options: CustomInfoDialogOptions(
                  title: '新客福利',
                  content: '注册7天内专属福利\n充的越多，奖励越多',
                  onConfirm: (_) => _showActionTip(context, '监听到：确定'),
                  onCancel: (_) => _showActionTip(context, '监听到：取消'),
                  onClose: (_) => _showActionTip(context, '监听到：关闭'),
                  onBarrierDismiss: (_) =>
                      _showActionTip(context, '监听到：点击遮罩关闭'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
