import 'package:app_frotas/app/modules/auth/data/models/auth_response_model.dart';

abstract class AuthDataSource {
  Future<AuthResponseModel> login(String username, String password);
  Future<AuthResponseModel> refreshToken(String token);
}
