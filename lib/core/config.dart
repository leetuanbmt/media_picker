library;

import 'package:flutter/services.dart';

import 'config.dart';

export 'package:auto_route/auto_route.dart';
export 'package:auto_size_text/auto_size_text.dart';
export 'package:flutter/material.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:gap/gap.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';

export '../../../l10n/app_localizations.dart';
export '../core/collections/collections.dart';
export '../core/extensions/extension.dart';
export '../core/utilities/logger.dart';
export '../widgets/commons/title_widget.dart';

part 'styles/theme.dart';

class AppConfigs {
  static const String baseUrl = 'https://reqres.in/api/';
  static const String title = 'Go Tip App';
  static const String twitterConsumerKey = '85AYa4yAaJWikw0lsIQYI1PKI';
  static const String twitterConsumerSecret =
      'jLpkhyazdKaVibDEqoQuJFjuxsCyj0Ugzu54vCC9gHHFY1yr77';
  static const authenticated = 'authenticated';

  static const websocketUrl = 'ws://10.1.15.65:1995';

  static const sentryDsn =
      'https://06c3a5a03ab9c5a100fba6dab6efade8@o4505984183369728.ingest.sentry.io/4505984184352768';
}
