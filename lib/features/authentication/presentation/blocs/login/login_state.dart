part of 'login_bloc.dart';

/// [LoginState] is a class that contains the different states of the login process.
/// It is used to update the UI based on the state of the login process.
/// It extends [Equatable] to compare the objects.
/// The different states are:
/// - [LoginInitial]: The initial state of the login process.
/// - [LoginLoading]: The state when the login process is in progress.
/// - [LoginSuccess]: The state when the login process is successful.
/// - [LoginFailure]: The state when the login process fails.
///
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserEntity user;
  final String token;

  const LoginSuccess({required this.user, required this.token});

  @override
  List<Object> get props => [user];
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}
