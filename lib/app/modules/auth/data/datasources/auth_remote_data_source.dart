import 'package:dio/dio.dart';

import 'auth_data_source.dart';

class AuthRemoteDataSource implements AuthDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Erro na autenticação: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
