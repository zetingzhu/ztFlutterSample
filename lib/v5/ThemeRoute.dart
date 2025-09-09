import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class ThemeRoute extends StatefulWidget {
  const ThemeRoute({super.key});

  @override
  State<ThemeRoute> createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('主题设置'), elevation: 0),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // 当前主题显示
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '当前主题',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        themeProvider.currentThemeName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 主题选择
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '选择主题',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                    ),

                    // 跟随系统
                    _buildThemeOption(
                      context,
                      themeProvider,
                      ThemeMode.system,
                      '跟随系统',
                      '根据系统设置自动切换主题',
                      Icons.brightness_auto,
                    ),

                    const Divider(height: 1),

                    // 浅色主题
                    _buildThemeOption(
                      context,
                      themeProvider,
                      ThemeMode.light,
                      '浅色主题',
                      '使用浅色背景和深色文字',
                      Icons.brightness_high,
                    ),

                    const Divider(height: 1),

                    // 深色主题
                    _buildThemeOption(
                      context,
                      themeProvider,
                      ThemeMode.dark,
                      '深色主题',
                      '使用深色背景和浅色文字',
                      Icons.brightness_2,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 重置按钮
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await themeProvider.clearTheme();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('已重置为系统默认主题'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('重置为系统默认'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemeMode themeMode,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = themeProvider.themeMode == themeMode;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colorScheme.primary)
          : null,
      onTap: () async {
        await themeProvider.setThemeMode(themeMode);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('已切换到$title'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }
}
