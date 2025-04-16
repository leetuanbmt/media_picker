class LanguageName {
  final String name;
  final String nativeName;

  const LanguageName({
    required this.name,
    required this.nativeName,
  });
}

abstract class LanguageLocals {
  static final Map isoLangs = {
    'en': const LanguageName(
      name: 'English',
      nativeName: 'English',
    ),
    'ja': const LanguageName(
      name: 'Japanese',
      nativeName: '日本語',
    ),
    'vi': const LanguageName(
      name: 'Vietnamese',
      nativeName: 'Tiếng Việt',
    ),
  };

  static LanguageName getDisplayLanguage(key) {
    if (isoLangs.containsKey(key)) {
      return isoLangs[key]!;
    } else {
      throw Exception('Language key incorrect');
    }
  }
}
