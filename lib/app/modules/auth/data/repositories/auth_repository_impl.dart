import 'package:app_frotas/app/modules/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Driver> login(String username, String password) async {
    try {
      final response = await remoteDataSource.login(username, password);

      await localDataSource.saveToken(response.data.authorization.token);

      return Driver(
        name: response.data.driverData.name,
        cpf: response.data.driverData.cpf,
      );
    } catch (e) {
      throw Exception('Erro ao fazer login: $e');
    }
  }

  @override
  Future refreshToken() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null || token.isEmpty) {
        throw Exception("token não encontrado");
      }

      final newAccessToken = await remoteDataSource.refreshToken(token);

      await localDataSource.saveToken(
        newAccessToken.data.authorization.token,
      );
    } catch (e) {
      throw Exception('Erro ao fazer renovar acesso: $e');
    }
  }
}
