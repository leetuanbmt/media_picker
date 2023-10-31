library media_picker;

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io' show File, Platform;
import 'dart:math' as math;
import 'dart:typed_data' as typed_data;
import 'dart:ui' as ui;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'constants/custom_scroll_physics.dart';
import 'constants/extensions.dart';
import 'internal/singleton.dart';
export 'package:photo_manager/photo_manager.dart';

part 'widget/platform_progress_indicator.dart';
part 'widget/scale_text.dart';
part 'widget/builder/video_page_builder.dart';
part 'widget/gaps.dart';
part 'constants/config.dart';
part 'constants/constants.dart';
part 'constants/enums.dart';
part 'constants/typedefs.dart';

part 'delegates/asset_picker_builder_delegate.dart';
part 'delegates/asset_picker_delegate.dart';
part 'delegates/asset_picker_text_delegate.dart';
part 'delegates/asset_picker_viewer_builder_delegate.dart';
part 'delegates/sort_path_delegate.dart';

part 'models/path_wrapper.dart';

part 'provider/asset_picker_provider.dart';
part 'provider/asset_picker_viewer_provider.dart';

part 'widget/asset_picker.dart';
part 'widget/asset_picker_app_bar.dart';
part 'widget/asset_picker_page_route.dart';
part 'widget/asset_picker_viewer.dart';
part 'widget/builder/asset_entity_grid_item_builder.dart';
part 'widget/builder/audio_page_builder.dart';
part 'widget/builder/fade_image_builder.dart';
part 'widget/builder/image_page_builder.dart';
part 'widget/builder/locally_available_builder.dart';
part 'widget/builder/value_listenable_builder_2.dart';
