import 'package:flutter/material.dart';

/// AlertDialog 简单教程
///
/// AlertDialog 是 Material 风格的模态对话框，常用于：
/// - 提示信息（标题 + 正文）
/// - 确认/取消操作
/// - 在 [actions] 中放置底部按钮
///
/// 显示方式：通过 [showDialog] 弹出，关闭时调用 [Navigator.pop]。
class AlertDialogSample extends StatelessWidget {
  const AlertDialogSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildSectionTitle('1. 基础提示框'),
        _buildDemoTile(
          context,
          title: '显示基础 AlertDialog',
          subtitle: '包含 title、content、actions',
          onTap: () => _showBasicAlert(context),
        ),
        _buildSectionTitle('2. 确认对话框'),
        _buildDemoTile(
          context,
          title: '删除确认',
          subtitle: '点击按钮后通过返回值判断用户选择',
          onTap: () => _showConfirmDialog(context),
        ),
        _buildSectionTitle('3. 点击遮罩关闭'),
        _buildDemoTile(
          context,
          title: 'barrierDismissible: true',
          subtitle: '点击对话框外部区域可关闭',
          onTap: () => _showDismissibleDialog(context),
        ),
        _buildSectionTitle('4. 仅内容区'),
        _buildDemoTile(
          context,
          title: 'Loading 样式',
          subtitle: '只使用 content，不设置 title 和 actions',
          onTap: () => _showLoadingDialog(context),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildDemoTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }

  /// 最基础的 AlertDialog：标题 + 内容 + 一个确认按钮。
  Future<void> _showBasicAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('提示'),
          content: const Text('这是一个最基础的 AlertDialog 示例。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('知道了'),
            ),
          ],
        );
      },
    );
  }

  /// 带「取消 / 确认」的对话框，通过 [showDialog] 的返回值获取用户选择。
  ///
  /// - 点击「取消」或遮罩：返回 `null`
  /// - 点击「删除」：返回 `true`
  Future<void> _showConfirmDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('确认删除'),
          content: const Text('删除后无法恢复，是否继续？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );

    if (!context.mounted) return;

    final message = confirmed == true ? '用户确认删除' : '用户取消操作';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  /// [barrierDismissible] 控制点击遮罩是否关闭对话框，默认为 `true`。
  Future<void> _showDismissibleDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('点击外部关闭'),
          content: const Text('点击对话框外的灰色区域即可关闭。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  /// AlertDialog 也可以只放 [content]，适合做加载提示等场景。
  Future<void> _showLoadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        // 演示用：2 秒后自动关闭
        Future.delayed(const Duration(seconds: 2), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(child: Text('正在加载，请稍候...')),
            ],
          ),
        );
      },
    );
  }
}
