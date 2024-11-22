import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

import 'package:app_frotas/app/modules/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/models/auth_response_model.dart';

import '../repositories/auth_repository_impl_test.mocks.dart';
import 'auth_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late AuthRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSource(
        dio: mockDio, authLocalDataSource: MockAuthLocalDataSource());
  });

  group('AuthRemoteDataSource', () {
    const username = 'testuser';
    const password = 'testpassword';
    const token = 'mockAccessToken';

    test('login deve retornar AuthResponseModel quando a API retorna sucesso',
        () async {
      final responseData = {
        "response_code": 0,
        "message": "sucesso",
        "data": {
          "authorization": {
            "type": "Bearer",
            "expires_in": 3600,
            "token": token,
          },
          "driver_data": {
            "name": "John Doe",
            "cpf": "12345678900",
          },
          "clients": []
        },
      };

      when(mockDio.post(
        '/appfrotas/driver/auth',
        data: {
          'username': username,
          'password': password,
        },
      )).thenAnswer((_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await dataSource.login(username, password);

      expect(result, isA<AuthResponseModel>());
      expect(result.data.authorization.token, token);
      expect(result.data.driverData.name, 'John Doe');
      verify(mockDio.post('/appfrotas/driver/auth', data: {
        'username': username,
        'password': password,
      })).called(1);
    });

    test('login deve lançar uma exceção quando a API retorna erro', () async {
      when(mockDio.post(
        '/appfrotas/driver/auth',
        data: {
          'username': username,
          'password': password,
        },
      )).thenThrow(DioException(
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      expect(() => dataSource.login(username, password), throwsException);
      verify(mockDio.post('/appfrotas/driver/auth', data: {
        'username': username,
        'password': password,
      })).called(1);
    });

    test('refreshToken deve retornar AuthResponseModel quando sucesso',
        () async {
      final responseData = {
        "response_code": 0,
        "message": "sucesso",
        "data": {
          "authorization": {
            "type": "Bearer",
            "expires_in": 3600,
            "token": token,
          },
          "driver_data": {
            "name": "John Doe",
            "cpf": "12345678900",
          },
          "clients": []
        },
      };

      when(mockDio.post(
        '/appfrotas/driver/refresh_token',
        data: {
          'Authorization': 'Bearer $token',
        },
      )).thenAnswer((_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      final result = await dataSource.refreshToken(token);

      expect(result, isA<AuthResponseModel>());
      expect(result.data.authorization.token, token);
      verify(mockDio.post('/appfrotas/driver/refresh_token', data: {
        'Authorization': 'Bearer $token',
      })).called(1);
    });

    test('refreshToken deve lançar uma exceção quando a API retorna erro',
        () async {
      when(mockDio.post(
        '/appfrotas/driver/refresh_token',
        data: {
          'Authorization': 'Bearer $token',
        },
      )).thenThrow(DioException(
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      expect(() => dataSource.refreshToken(token), throwsException);
      verify(mockDio.post('/appfrotas/driver/refresh_token', data: {
        'Authorization': 'Bearer $token',
      })).called(1);
    });
  });
}
