extension StringGoTopExt on String? {
  String get removeIcon => (this ?? '').split(' ').last;
  bool get isNotEmptyAndNotNull => this != null && this!.isNotEmpty;
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}
