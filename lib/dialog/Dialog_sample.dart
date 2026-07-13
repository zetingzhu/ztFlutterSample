import 'package:flutter/material.dart';

/// Dialog 简单教程
///
/// [Dialog] 是最基础的弹框容器，只提供圆角卡片外壳，内部布局完全自定义。
///
/// 三者对比：
/// - [Dialog]：空白容器，自由度最高，适合自定义 UI、列表、复杂布局
/// - [AlertDialog]：固定结构（title + content + actions），适合确认/提示
/// - [SimpleDialog]：固定结构（title + 选项列表），适合单选
class DialogSample extends StatelessWidget {
  const DialogSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildCompareCard(),
        _buildSectionTitle('1. 基础 Dialog'),
        _buildDemoTile(
          context,
          title: '自定义内容布局',
          subtitle: 'Dialog 内部可放任意 Widget',
          onTap: () => _showBasicDialog(context),
        ),
        _buildSectionTitle('2. 列表弹框'),
        _buildDemoTile(
          context,
          title: '可滚动列表选择',
          subtitle: 'AlertDialog 放 ListView 会报错，Dialog 可以',
          onTap: () => _showListDialog(context),
        ),
        _buildSectionTitle('3. 自定义圆角'),
        _buildDemoTile(
          context,
          title: 'shape 控制外观',
          subtitle: '通过 shape、背景色定制样式',
          onTap: () => _showShapedDialog(context),
        ),
        _buildSectionTitle('4. 透明背景'),
        _buildDemoTile(
          context,
          title: 'backgroundColor: transparent',
          subtitle: '适合完全自定义外观的弹框（如顶部图片弹框）',
          onTap: () => _showTransparentDialog(context),
        ),
      ],
    );
  }

  Widget _buildCompareCard() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '三种弹框对比',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            _CompareRow(
              name: 'Dialog',
              desc: '空白容器，内部完全自定义',
              scene: '自定义 UI、列表、复杂布局',
              color: Color(0xFF1676FE),
            ),
            Divider(height: 20),
            _CompareRow(
              name: 'AlertDialog',
              desc: 'title + content + actions',
              scene: '确认、提示、警告',
              color: Color(0xFF26A57D),
            ),
            Divider(height: 20),
            _CompareRow(
              name: 'SimpleDialog',
              desc: 'title + SimpleDialogOption 列表',
              scene: '单选、语言/主题切换',
              color: Color(0xFFF8510E),
            ),
          ],
        ),
      ),
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

  /// 最基础的 Dialog：只有一个圆角容器，内容自己拼。
  Future<void> _showBasicDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 48, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  '这是 Dialog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Text(
                  'AlertDialog 和 SimpleDialog 都是基于 Dialog 封装好的样式。',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('关闭'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 列表弹框：AlertDialog 的 content 有高度约束，直接放 ListView 会报错。
  Future<void> _showListDialog(BuildContext context) async {
    final selected = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          child: SizedBox(
            width: 300,
            height: 400,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    '请选择',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text('选项 $index'),
                        onTap: () => Navigator.of(dialogContext).pop(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!context.mounted || selected == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('你选择了：选项 $selected')),
    );
  }

  /// 通过 [shape] 自定义圆角和边框。
  Future<void> _showShapedDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 280,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '圆角 Dialog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text('通过 shape 参数可以自定义弹框外观。'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('取消'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('确定'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 透明背景 Dialog：内部自己画白色卡片，适合复杂自定义弹框。
  Future<void> _showTransparentDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: 280,
                margin: const EdgeInsets.only(top: 36),
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '透明 Dialog',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '设置 backgroundColor: transparent 后，'
                      '可以自己控制卡片样式，常用于营销弹框。',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('知道了'),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 36,
                backgroundColor: Color(0xFF1676FE),
                child: Icon(Icons.card_giftcard, color: Colors.white, size: 32),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.name,
    required this.desc,
    required this.scene,
    required this.color,
  });

  final String name;
  final String desc;
  final String scene;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 2),
              Text(
                '适用：$scene',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
