import 'package:hooks_riverpod/hooks_riverpod.dart';

final categoryProvider = StateProvider.autoDispose<List<String>>((ref) => []);
