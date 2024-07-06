part of 'sign_up_bloc.dart';

/// [SignUpEvent] is a class that contains the different events of the sign up process.
/// It is used to trigger the different events of the sign up process.
/// It extends [Equatable] to compare the objects.
/// The different events are:
/// - [SignUpButtonPressed]: The event when the user presses the sign up button.
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  const SignUpButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
