import 'package:app_frotas/app/modules/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_frotas/app/modules/auth/data/models/auth_response_model.dart';
import 'package:dio/dio.dart';

import 'auth_data_source.dart';

class AuthRemoteDataSource implements AuthDataSource {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  AuthRemoteDataSource({required this.dio, required this.authLocalDataSource});

  @override
  Future<AuthResponseModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/appfrotas/driver/auth',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception('Erro na autenticação: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  @override
  Future<AuthResponseModel> refreshToken(String token) async {
    try {
      final response = await dio.post(
        '/appfrotas/driver/refresh_token',
        data: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.data["response_code"] == 0) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception('Ocorreu um erro: ${response.data["message"]}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
