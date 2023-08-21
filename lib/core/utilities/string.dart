class StringUtils {
  factory StringUtils() {
    return _instance;
  }

  StringUtils._internal();
  static final StringUtils _instance = StringUtils._internal();
}
