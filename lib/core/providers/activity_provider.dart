import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/activity/activity.dart';
import 'common_provider.dart';

part 'activity_provider.g.dart';

@riverpod
Future<Activity> activity(ActivityRef ref) async {
  final client = ref.watch(clientProvider);
  final uri = Uri.https('boredapi.com', '/api/activity');
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final response = await client.getUri(uri, cancelToken: cancelToken);
  return Activity.fromJson(response.data);
}
