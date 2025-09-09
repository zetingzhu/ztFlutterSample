import 'package:flutter/material.dart';
import '../v5/ThemeRoute.dart';
import '../v5/LanguageUtil.dart';

class TPage5 extends StatelessWidget {
  const TPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),

          // 设置标题
          Text(
            '设置',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          // 外观设置卡片
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '外观设置',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // 主题设置
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('主题设置'),
                  subtitle: const Text('切换浅色/深色主题'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThemeRoute(),
                      ),
                    );
                  },
                ),

                const Divider(height: 1),

                // 语言设置
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('语言设置'),
                  subtitle: const Text('切换应用语言'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LanguageSetting(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 其他设置卡片
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '其他设置',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('关于应用'),
                  subtitle: const Text('版本信息和开发者信息'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Flutter学习示例',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(Icons.flutter_dash),
                      children: [
                        const Text('这是一个Flutter学习示例应用，包含了主题切换和多语言支持功能。'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
