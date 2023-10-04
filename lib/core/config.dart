library config;

import 'package:flutter/services.dart';

import 'config.dart';
import 'utilities/preferences.dart';

export 'package:auto_route/auto_route.dart';
export 'package:auto_size_text/auto_size_text.dart';
export 'package:easy_localization/easy_localization.dart' hide TextDirection;
export 'package:flutter/material.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';
export 'package:velocity_x/velocity_x.dart';

export '../core/extensions/extension.dart';
export '../core/utilities/logger.dart';

part 'styles/dimensions.dart';
part 'styles/theme.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

enum Flavor { dev, staging, prod }

class AppConfig {
  AppConfig._();
  static const String title = 'Go Tip App';
  static const String baseUrl = 'https://reqres.in/api/';
  static const String twitterConsumerKey = '85AYa4yAaJWikw0lsIQYI1PKI';
  static const String twitterConsumerSecret =
      'jLpkhyazdKaVibDEqoQuJFjuxsCyj0Ugzu54vCC9gHHFY1yr77';
  static const themeColor = "themeColor";
  static const authenticated = "authenticated";
  static const email = "email";
  static const password = "password";
  static const checkSaveAccount = "checkSaveAccount";
  static const websocketUrl = 'ws://10.1.15.65:1995';
  static const sentryDsn =
      'https://06c3a5a03ab9c5a100fba6dab6efade8@o4505984183369728.ingest.sentry.io/4505984184352768';
}
