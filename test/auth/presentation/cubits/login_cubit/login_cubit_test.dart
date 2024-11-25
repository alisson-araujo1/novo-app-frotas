import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/domain/usecases/login_driver.dart';
import 'package:app_frotas/app/modules/auth/presentation/cubits/login_cubit/login_cubit.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginDriver])
void main() {
  late MockLoginDriver mockLoginDriver;
  late LoginCubit loginCubit;

  setUp(() {
    mockLoginDriver = MockLoginDriver();
    loginCubit = LoginCubit(loginDriver: mockLoginDriver);
  });

  tearDown(() {
    loginCubit.close();
  });

  const username = 'test_user';
  const password = 'test_password';

  final driver = Driver(
    name: 'João da Silva',
    cpf: '12345678900',
  );

  group('LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'emite [LoginLoading, LoginSuccess] quando login é bem-sucedido',
      build: () {
        when(mockLoginDriver.call(username, password))
            .thenAnswer((_) async => driver);
        return loginCubit;
      },
      act: (cubit) => cubit.login(username, password),
      expect: () => [
        LoginLoading(),
        LoginSuccess(driver: driver),
      ],
      verify: (_) {
        verify(mockLoginDriver.call(username, password)).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emite [LoginLoading, LoginFailure] quando login falha',
      build: () {
        when(mockLoginDriver.call(username, password))
            .thenThrow(Exception('Invalid credentials'));
        return loginCubit;
      },
      act: (cubit) => cubit.login(username, password),
      expect: () => [
        LoginLoading(),
        LoginFailure(message: 'Error: Exception: Invalid credentials'),
      ],
      verify: (_) {
        verify(mockLoginDriver.call(username, password)).called(1);
      },
    );
  });
}
