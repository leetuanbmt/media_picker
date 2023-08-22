library config;

import 'config.dart';

export 'package:auto_route/auto_route.dart';
export 'package:auto_size_text/auto_size_text.dart';
export 'package:easy_localization/easy_localization.dart' hide TextDirection;
export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:velocity_x/velocity_x.dart';

export '../core/models/theme_color_model.dart';
export '../notifiers/theme_color_notifier.dart';

part 'styles/dimensions.dart';
part 'styles/theme.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

enum Flavor { dev, staging, prod }

class AppConfig {
  AppConfig._();
  static const title = 'Go Tip App';
  static const baseUrl = 'https://reqres.in/api/';
}
