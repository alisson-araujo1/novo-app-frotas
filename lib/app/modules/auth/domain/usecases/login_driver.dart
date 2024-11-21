import 'package:app_frotas/app/modules/auth/domain/repositories/auth_repository.dart';

class LoginDriver {
  final AuthRepository authRepository;

  LoginDriver(this.authRepository);

  Future<UserResult> call(String username, String password) async {
    return await authRepository.login(username, password);
  }
}

class UserResult {
  final bool isManager;

  UserResult({required this.isManager});
}
