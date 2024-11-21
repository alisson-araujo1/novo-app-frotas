import 'package:app_frotas/app/modules/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future login(String username, String password) async {
    final response = await remoteDataSource.login(username, password);

    //TODO: implementar a logica
  }
}
