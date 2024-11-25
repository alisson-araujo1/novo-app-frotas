import 'package:app_frotas/app/modules/auth/domain/entities/driver.dart';
import 'package:app_frotas/app/modules/auth/domain/usecases/login_driver.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginDriver loginDriver;
  LoginCubit({required this.loginDriver}) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final user = await loginDriver.call(username, password);
      await Future.delayed(const Duration(seconds: 2));
      emit(LoginSuccess(driver: user));
    } catch (e) {
      emit(LoginFailure(message: 'Error: $e'));
    }
  }
}
