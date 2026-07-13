import 'package:flutter/material.dart';

/// SimpleDialog 简单教程
///
/// SimpleDialog 适合展示一组可选项，例如：
/// - 语言切换
/// - 主题选择
/// - 简单列表选择
///
/// 每个选项通常使用 [SimpleDialogOption] 包裹，
/// 选中后通过 [Navigator.pop] 把结果返回给调用方。
class SimpleDialogSample extends StatefulWidget {
  const SimpleDialogSample({super.key});

  @override
  State<SimpleDialogSample> createState() => _SimpleDialogSampleState();
}

class _SimpleDialogSampleState extends State<SimpleDialogSample> {
  String _language = '中文简体';
  String _theme = '跟随系统';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        _buildSectionTitle('当前选择'),
        ListTile(
          title: const Text('语言'),
          subtitle: Text(_language),
          leading: const Icon(Icons.language),
        ),
        ListTile(
          title: const Text('主题'),
          subtitle: Text(_theme),
          leading: const Icon(Icons.palette_outlined),
        ),
        const Divider(),
        _buildSectionTitle('1. 基础选择框'),
        _buildDemoTile(
          title: '选择语言',
          subtitle: '使用 SimpleDialogOption 列出选项',
          onTap: () => _showLanguageDialog(context),
        ),
        _buildSectionTitle('2. 带图标选项'),
        _buildDemoTile(
          title: '选择主题',
          subtitle: '在选项中自定义 Row / Icon 布局',
          onTap: () => _showThemeDialog(context),
        ),
        _buildSectionTitle('3. 列表式选择'),
        _buildDemoTile(
          title: '选择城市',
          subtitle: '选项较多时仍可使用 SimpleDialog',
          onTap: () => _showCityDialog(context),
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

  Widget _buildDemoTile({
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

  /// 最基础的 SimpleDialog：标题 + 多个 [SimpleDialogOption]。
  Future<void> _showLanguageDialog(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop('中文简体'),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop('English'),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('English'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop('日本語'),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('日本語'),
              ),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() => _language = selected);
    }
  }

  /// SimpleDialogOption 的 child 可以是任意 Widget，不仅限于纯文本。
  Future<void> _showThemeDialog(BuildContext context) async {
    final themes = <({String label, IconData icon})>[
      (label: '跟随系统', icon: Icons.settings_suggest_outlined),
      (label: '浅色模式', icon: Icons.light_mode_outlined),
      (label: '深色模式', icon: Icons.dark_mode_outlined),
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('请选择主题'),
          children: themes
              .map(
                (item) => SimpleDialogOption(
                  onPressed: () => Navigator.of(dialogContext).pop(item.label),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(item.icon, size: 20),
                        const SizedBox(width: 12),
                        Text(item.label),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );

    if (selected != null) {
      setState(() => _theme = selected);
    }
  }

  /// 选项较多时，SimpleDialog 会自动处理滚动。
  Future<void> _showCityDialog(BuildContext context) async {
    const cities = ['北京', '上海', '广州', '深圳', '杭州', '成都', '武汉', '西安'];

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('请选择城市'),
          children: cities
              .map(
                (city) => SimpleDialogOption(
                  onPressed: () => Navigator.of(dialogContext).pop(city),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(city),
                  ),
                ),
              )
              .toList(),
        );
      },
    );

    if (!context.mounted || selected == null) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('你选择了：$selected')));
  }
}
