import 'package:app_frotas/app/di/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_driver.dart';

void setupAuthDependencies() {
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(storage: getIt<FlutterSecureStorage>()),
  );
  getIt.registerLazySingleton(
    () => AuthRemoteDataSource(
        dio: getIt<Dio>(), authLocalDataSource: getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => LoginDriver(getIt<AuthRepositoryImpl>()),
  );
}
