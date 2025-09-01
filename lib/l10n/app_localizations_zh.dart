// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get zztTitle => 'ZZT Flutter 学习记录';

  @override
  String get s1_1 => '主页';

  @override
  String get s1_2 => '聊天';

  @override
  String get s1_3 => '房间';

  @override
  String get s1_4 => '会议';

  @override
  String get s1_5 => '设置';

  @override
  String get helloWorld => '你好世界！！！';

  @override
  String hello(String userName) {
    return 'Hello $userName';
  }

  @override
  String nWombats(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString wombats',
      one: '1 wombat',
      zero: 'no wombats',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'he',
      'female': 'she',
      'other': 'they',
    });
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.compactCurrency(locale: localeName, decimalDigits: 2);
    final String valueString = valueNumberFormat.format(value);

    return 'Number of data points: $valueString';
  }

  @override
  String get selectLanguage => '选择语言';

  @override
  String get languageSettings => '语言设置';

  @override
  String get languageChanged => '语言已切换为';

  @override
  String get cancel => '取消';
}
