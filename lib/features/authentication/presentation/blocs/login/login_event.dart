part of 'login_bloc.dart';

/// [LoginEvent] is a class that contains the different events of the login process.
/// It is used to trigger the different events of the login process.
/// It extends [Equatable] to compare the objects.
/// The different events are:
/// - [LoginButtonPressed]: The event when the user presses the login button.
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
