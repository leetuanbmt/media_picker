import 'package:flutter/material.dart';

class LanguageModel {
  final Locale locale;
  final String name;

  LanguageModel(this.locale, this.name);
}

class AppLanguage {
  AppLanguage._();

  static Locale defaultLanguage = const Locale('en');

  static final supportLanguage = <LanguageModel>[
    LanguageModel(const Locale('en'), 'English'),
    LanguageModel(const Locale('vi'), 'Vietnamese'),
  ];

  static List<Locale> get supports =>
      supportLanguage.map((e) => e.locale).toList();
}
