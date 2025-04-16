import 'package:dio/dio.dart';

import '../config.dart';
import '../repositories/base_repository.dart';
import '../utilities/dio_interceptor.dart';

final clientProvider = Provider(
  (ref) => Dio(
    BaseOptions(
      baseUrl: AppConfigs.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(DioInterceptor()),
);

final repositoryProvider = Provider(
  (ref) => AppRepositoriesImpl(
    clientProvider: ref.read(clientProvider),
  ),
);
