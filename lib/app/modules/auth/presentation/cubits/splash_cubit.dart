import 'package:app_frotas/app/core/constants/app_constants.dart';
import 'package:bloc/bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkUser() {
    emit(SplashSuccessState(userType: AccessType.driver));
  }
}
