import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/models/activity/activity.dart';
import 'providers.dart';

part 'activity_provider.g.dart';

@riverpod
Future<Activity> activity(ActivityRef ref) async {
  final response = await ref.watch(appProvider).dio.getUri(
        Uri.https('boredapi.com', '/api/activity'),
      );
  return Activity.fromJson(response.data);
}
