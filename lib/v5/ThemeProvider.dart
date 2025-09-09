import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _selectedThemeModeKey = 'selected_theme_mode';
const String _defaultThemeMode = 'system';

/// 主题提供者
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;
  Future<SharedPreferences>? _prefsFuture;

  ThemeProvider() : _themeMode = ThemeMode.system {
    _prefsFuture = SharedPreferences.getInstance();
  }

  ThemeMode get themeMode => _themeMode;

  Future<SharedPreferences> get _prefs async => await _prefsFuture!;

  /// 异步加载已保存的主题设置
  Future<void> loadTheme() async {
    ThemeMode initialTheme = _themeMode;
    ThemeMode themeToSet = ThemeMode.system;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? themeModeString = prefs.getString(_selectedThemeModeKey);
      if (themeModeString != null) {
        themeToSet = _stringToThemeMode(themeModeString);
      }
    } catch (e) {
      // 如果加载失败，使用默认主题
    }

    if (initialTheme != themeToSet) {
      _themeMode = themeToSet;
      notifyListeners();
    } else {
      _themeMode = themeToSet;
    }
  }

  /// 设置新的主题模式
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    if (_themeMode != newThemeMode) {
      _themeMode = newThemeMode;
      notifyListeners();

      try {
        final prefs = await _prefs;
        await prefs.setString(
          _selectedThemeModeKey,
          _themeModeToString(newThemeMode),
        );
      } catch (e) {
        // 保存失败时的处理
      }
    }
  }

  /// 清除已保存的主题设置，恢复到系统默认
  Future<void> clearTheme() async {
    _themeMode = ThemeMode.system;
    notifyListeners();

    try {
      final prefs = await _prefs;
      await prefs.remove(_selectedThemeModeKey);
    } catch (e) {
      // 清除失败时的处理
    }
  }

  /// 将ThemeMode转换为字符串
  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// 将字符串转换为ThemeMode
  ThemeMode _stringToThemeMode(String themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  /// 获取当前主题模式的显示名称
  String get currentThemeName {
    switch (_themeMode) {
      case ThemeMode.light:
        return '浅色主题';
      case ThemeMode.dark:
        return '深色主题';
      case ThemeMode.system:
        return '跟随系统';
    }
  }
}
