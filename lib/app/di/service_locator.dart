import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupCoreDependencies() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton(() => Dio());
}
