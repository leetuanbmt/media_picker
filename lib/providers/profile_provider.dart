import 'package:hooks_riverpod/hooks_riverpod.dart';

final pointConfirmChangeCardProvider =
    StateProvider.autoDispose<int>((ref) => 0);
