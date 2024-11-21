import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSource({required this.storage});

  Future<void> saveToken(String token) async {
    await storage.write(key: 'accessToken', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future<void> clearToken() async {
    await storage.delete(key: 'accessToken');
  }
}
