part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoadingState extends SplashState {}

final class SplashSuccessState extends SplashState {
  final AccessType userType;

  SplashSuccessState({required this.userType});
}

final class SplashErrorState extends SplashState {
  final String message;

  SplashErrorState({required this.message});
}
