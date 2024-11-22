import '../repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository authRepository;

  RefreshToken(this.authRepository);

  Future<String> call() async {
    return await authRepository.refreshToken();
  }
}
