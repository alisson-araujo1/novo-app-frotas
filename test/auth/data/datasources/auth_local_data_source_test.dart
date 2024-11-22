import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_frotas/app/modules/auth/data/datasources/auth_local_data_source.dart';

import 'auth_local_data_source_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late AuthLocalDataSource dataSource;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    dataSource = AuthLocalDataSource(storage: mockStorage);
  });

  group('AuthLocalDataSource', () {
    const token = 'mockToken';
    const tokenKey = 'accessToken';

    test('deve salvar o token no storage', () async {
      await dataSource.saveToken(token);

      verify(mockStorage.write(key: tokenKey, value: token)).called(1);
    });

    test('deve recuperar o token do storage', () async {
      when(mockStorage.read(key: tokenKey)).thenAnswer((_) async => token);

      final result = await dataSource.getToken();

      expect(result, token);
      verify(mockStorage.read(key: tokenKey)).called(1);
    });

    test('deve limpar o token no storage', () async {
      await dataSource.clearToken();

      verify(mockStorage.delete(key: tokenKey)).called(1);
    });
  });
}
