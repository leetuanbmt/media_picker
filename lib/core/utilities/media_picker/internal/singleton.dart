import 'package:flutter/widgets.dart';

import '../media_picker.dart';

class Singleton {
  const Singleton._();

  static AssetPickerTextDelegate textDelegate = const AssetPickerTextDelegate();
  static SortPathDelegate<dynamic> sortPathDelegate = SortPathDelegate.common;

  static ScrollPosition? scrollPosition;
}
