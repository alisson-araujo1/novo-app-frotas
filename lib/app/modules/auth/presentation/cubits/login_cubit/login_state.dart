part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final Driver driver;

  LoginSuccess({required this.driver});
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
