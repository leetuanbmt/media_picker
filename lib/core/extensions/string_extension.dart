import '../utilities/preferences.dart';

extension StringGoTopExt on String? {
  void setString(String value) async {
    await Preferences.setString(this!, value);
  }

  void setBool(bool value) async {
    await Preferences.setBool(this!, value);
  }

  void setInt(int value) async {
    await Preferences.setInt(this!, value);
  }

  void setDouble(double value) async {
    await Preferences.setDouble(this!, value);
  }

  void setStringList(List<String> value) async {
    await Preferences.setStringList(this!, value);
  }

  String? getString() {
    return Preferences.getString(this!);
  }

  bool getBool() {
    return Preferences.getBool(this!);
  }

  int? getInt() {
    return Preferences.getInt(this!);
  }

  String get removeIcon => (this ?? '').split(" ").last;
}
