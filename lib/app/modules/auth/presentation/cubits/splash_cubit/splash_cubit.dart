import 'package:app_frotas/app/core/constants/app_constants.dart';
import 'package:bloc/bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkUser() async {
    emit(SplashLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashErrorState(message: 'Unauthorized'));
  }
}
