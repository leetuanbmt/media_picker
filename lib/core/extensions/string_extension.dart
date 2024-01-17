extension StringGoTopExt on String? {
  String get removeIcon => (this ?? '').split(' ').last;
}
