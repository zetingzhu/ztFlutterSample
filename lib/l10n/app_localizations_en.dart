// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get zztTitle => 'ZZT Flutter Simple example';

  @override
  String get s1_1 => 'Main';

  @override
  String get s1_2 => 'Chat';

  @override
  String get s1_3 => 'Rooms';

  @override
  String get s1_4 => 'Meet';

  @override
  String get s1_5 => 'Setting';

  @override
  String get helloWorld => 'Hello World!';

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
  String get selectLanguage => 'Select Language';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get languageChanged => 'Language changed to';

  @override
  String get cancel => 'Cancel';
}
