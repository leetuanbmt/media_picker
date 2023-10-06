import '../config.dart';

class LanguageModel {
  final Locale locale;
  final String name, value;

  LanguageModel(this.locale, this.name, this.value);
}

class AppLanguage {
  AppLanguage._();

  static Locale defaultLanguage = const Locale('ja');

  static final supportLanguage = <LanguageModel>[
    LanguageModel(const Locale('ja'), 'Japanese', 'japanese'),
    LanguageModel(const Locale('en'), 'English', 'english'),
    LanguageModel(const Locale('vi'), 'Vietnamese', 'vietnamese'),
  ];

  static List<Locale> get supports =>
      supportLanguage.map((e) => e.locale).toList();

  static Locale currentLanguageCode = defaultLanguage;

  static Locale get currentLanguage => currentLanguageCode;

  static String get currentLanguageValue =>
      supportLanguage.firstWhere((e) => e.locale == currentLanguage).value;

  static void changeLanguage(BuildContext context, Locale locale) {
    currentLanguageCode = locale;
    EasyLocalization.of(context)?.setLocale(locale);
  }
}
