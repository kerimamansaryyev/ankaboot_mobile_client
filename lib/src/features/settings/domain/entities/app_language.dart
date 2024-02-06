import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const _enLangCode = 'en';

enum AppLanguage {
  en._(_enLangCode, 'English');

  final String languageCode;
  final String readableLabel;

  const AppLanguage._(
    this.languageCode,
    this.readableLabel,
  );

  factory AppLanguage.fromLanguageCode(String lCode) =>
      _stringMapped[lCode] ?? fallback;

  Locale get locale => Locale(languageCode);

  static const fallback = en;
  static const delegates = <LocalizationsDelegate>[
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const _stringMapped = <String, AppLanguage>{
    _enLangCode: en,
  };

  static final supportedLocales = values.map((e) => e.locale);

  static AppLocalizations? translation(BuildContext context) =>
      AppLocalizations.of(context);
}
