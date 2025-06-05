import 'package:flutter/widgets.dart';

import '../delegates/asset_picker_text_delegate.dart';
import '../delegates/sort_path_delegate.dart';

class Singleton {
  const Singleton._();

  static AssetPickerTextDelegate textDelegate = const AssetPickerTextDelegate();
  static SortPathDelegate<dynamic> sortPathDelegate = SortPathDelegate.common;

  static ScrollPosition? scrollPosition;
}
