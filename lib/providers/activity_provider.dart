import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/models/activity/activity.dart';

part 'activity_provider.g.dart';

@riverpod
Future<Activity> activity(ActivityRef ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await Dio().getUri(
    Uri.https('boredapi.com', '/api/activity'),
  );
  return Activity.fromJson(response.data);
}
