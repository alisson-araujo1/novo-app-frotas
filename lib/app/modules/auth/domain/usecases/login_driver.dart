import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart';

class LoginDriver {
  final AuthRepository authRepository;

  LoginDriver(this.authRepository);

  Future<Driver> call(String username, String password) async {
    return await authRepository.login(username, password);
  }
}
