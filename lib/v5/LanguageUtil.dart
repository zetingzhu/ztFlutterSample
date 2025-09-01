import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../l10n/LocaleProvider.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Map<String, String> languageMap = {
  'zh': '简体中文',
  'en': 'English',
  'es': 'Español',
};

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => LanguageState();
}

class LanguageState extends State<LanguageSetting> {
  var isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final String currentLanguageCode = localeProvider.locale!.languageCode;
    final entries = languageMap.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languageSettings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final languageCode = entry.key;
          final languageName = entry.value;
          final bool isSelected = languageCode == currentLanguageCode;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300],
              child: Text(
                languageCode.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            title: Text(languageName, style: TextStyle(fontSize: 16)),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.blue, size: 24)
                : const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                    size: 24,
                  ),
            onTap: () => _changeLanguage(localeProvider, languageCode),
          );
        },
      ),
    );
  }

  Future<void> _changeLanguage(
    LocaleProvider localeProvider,
    String languageCode,
  ) async {
    localeProvider.setLocale(Locale(languageCode));
  }
}
