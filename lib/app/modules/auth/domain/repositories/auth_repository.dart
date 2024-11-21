import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';

abstract class AuthRepository {
  Future login(Driver user);
}
