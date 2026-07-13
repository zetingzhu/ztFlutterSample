import 'package:flutter/material.dart';

import 'custom_info_dialog.dart';

/// 自定义弹框教程：演示公用弹框的三种按钮监听。
class CustomDialogSample extends StatelessWidget {
  const CustomDialogSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            '公用弹框支持确定、取消、关闭三种独立监听。',
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        ),
        ListTile(
          title: const Text('显示自定义弹框'),
          subtitle: const Text('onConfirm / onCancel / onClose / onBarrierDismiss'),
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
    );
  }

  void _showActionTip(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
