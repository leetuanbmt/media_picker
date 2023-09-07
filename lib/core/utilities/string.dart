class Strings {
  factory Strings() => _instance;

  Strings._internal();
  static final Strings _instance = Strings._internal();

  static const themeColor = "themeColor";
  static const authenticated = "authenticated";
}
