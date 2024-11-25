import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:app_frotas/app/modules/auth/domain/usecases/login_driver.dart';
import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart';

import 'login_driver_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginDriver usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginDriver(mockAuthRepository);
  });

  const username = 'test_user';
  const password = 'test_password';
  final driver = Driver(name: 'João da Silva', cpf: '12345678900');

  group('LoginDriver', () {
    test('deve retornar um Driver ao chamar o repositório com sucesso',
        () async {
      // Arrange
      when(mockAuthRepository.login(username, password))
          .thenAnswer((_) async => driver);

      // Act
      final result = await usecase(username, password);

      // Assert
      expect(result, driver);
      verify(mockAuthRepository.login(username, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('deve lançar uma exceção quando o repositório falhar', () async {
      // Arrange
      when(mockAuthRepository.login(username, password))
          .thenThrow(Exception('Erro ao fazer login'));

      // Act
      expect(() => usecase(username, password), throwsException);

      // Assert
      verify(mockAuthRepository.login(username, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
