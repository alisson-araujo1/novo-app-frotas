import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:app_frotas/app/modules/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/data/models/auth_response_model.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('AuthRepositoryImpl', () {
    const username = 'testuser';
    const password = 'testpassword';
    const token = 'mockAccessToken';
    const refreshToken = 'mockRefreshToken';

    final authResponseModel = AuthResponseModel(
      responseCode: 0,
      message: 'Sucesso',
      data: DataModel(
          authorization: AuthorizationModel(
            type: 'Bearer',
            token: token,
            expiresIn: 3600,
          ),
          driverData: DriverDataModel(
            name: 'João da Silva',
            cpf: '12345678900',
          ),
          clients: []),
    );

    test('login deve retornar Driver quando sucesso', () async {
      when(mockRemoteDataSource.login(username, password))
          .thenAnswer((_) async => authResponseModel);

      final result = await repository.login(username, password);

      expect(result, isA<Driver>());
      expect(result.name, 'João da Silva');
      expect(result.cpf, '12345678900');
      verify(mockRemoteDataSource.login(username, password)).called(1);
      verify(mockLocalDataSource.saveToken(token)).called(1);
    });

    test('login deve lançar uma exceção em caso de erro', () async {
      when(mockRemoteDataSource.login(username, password))
          .thenThrow(Exception('Erro ao fazer login'));

      expect(() => repository.login(username, password), throwsException);

      verify(mockRemoteDataSource.login(username, password)).called(1);
      verifyNever(mockLocalDataSource.saveToken(any));
    });

    test('refreshToken deve salvar novo token quando sucesso', () async {
      when(mockLocalDataSource.getToken())
          .thenAnswer((_) async => refreshToken);
      when(mockRemoteDataSource.refreshToken(refreshToken))
          .thenAnswer((_) async => authResponseModel);

      await repository.refreshToken();

      verify(mockLocalDataSource.getToken()).called(1);
      verify(mockRemoteDataSource.refreshToken(refreshToken)).called(1);
      verify(mockLocalDataSource.saveToken(token)).called(1);
    });

    test('refreshToken deve lançar uma exceção se token não encontrado',
        () async {
      when(mockLocalDataSource.getToken()).thenAnswer((_) async => null);

      expect(() => repository.refreshToken(), throwsException);

      verify(mockLocalDataSource.getToken()).called(1);
      verifyNever(mockRemoteDataSource.refreshToken(any));
    });
  });
}
