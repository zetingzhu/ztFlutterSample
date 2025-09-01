import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';

const String _selectedLanguageCodeKey = 'selected_language_code';
const String _defaultLanguageCode = 'en';

/// 简体修改语言提供者
class LocaleProvider with ChangeNotifier {
  Locale _locale;
  Future<SharedPreferences>? _prefsFuture; // 用于缓存 SharedPreferences Future

  LocaleProvider() : _locale = const Locale(_defaultLanguageCode) {
    _prefsFuture = SharedPreferences.getInstance(); // 应用启动时就开始获取
  }

  Locale? get locale => _locale;

  Future<SharedPreferences> get _prefs async => await _prefsFuture!;

  /// 异步加载已保存的语言设置。
  Future<void> loadLocale() async {
    Locale initialLocale = _locale; // 保存调用此方法时的当前 locale (通常是默认值)
    Locale localeToSet = const Locale(_defaultLanguageCode); // 默认情况下，设置为应用默认语言

    try {
      final prefs = await SharedPreferences.getInstance();
      String? languageCode = prefs.getString(_selectedLanguageCodeKey);
      if (languageCode != null && _isSupported(Locale(languageCode))) {
        localeToSet = Locale(languageCode);
      }
    } catch (e) {}
    if (initialLocale.languageCode != localeToSet.languageCode) {
      _locale = localeToSet;
      notifyListeners();
    } else {
      // 即使语言没变，也确保 _locale 被正确赋值 (如果之前由于某种原因不是初始的 default)
      _locale = localeToSet;
    }
  }

  /// 设置新的应用语言环境。
  Future<void> setLocale(Locale newLocale) async {
    // ... (检查和更新 _locale) ...
    if (_isSupported(newLocale) &&
        _locale.languageCode != newLocale.languageCode) {
      _locale = newLocale;
      notifyListeners();
      try {
        final prefs = await _prefs; // 使用缓存的 Future
        await prefs.setString(_selectedLanguageCodeKey, newLocale.languageCode);
      } catch (e) {
        /* ... */
      }
    }
  }

  /// 清除已保存的语言设置，并恢复到默认语言。
  ///
  /// 此方法会将当前语言环境重置为默认语言，
  /// 并从 SharedPreferences 中移除已保存的语言代码。
  void clearLocale() async {
    _locale = const Locale(
      _defaultLanguageCode,
    ); // Or system locale, or null if you handle it
    notifyListeners();

    try {
      final prefs = await _prefs; // 使用缓存的 Future
      await prefs.remove(_selectedLanguageCodeKey);
    } catch (e) {
      /* ... */
    }
  }

  /// 检查给定的语言环境是否在应用支持的语言列表 (`AppLocalizations.supportedLocales`) 中。
  ///
  /// [locale] - 需要检查的语言环境。
  /// 返回 `true` 如果支持，否则返回 `false`。
  bool _isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }
}
