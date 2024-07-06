part of 'sign_up_bloc.dart';

/// [SignUpState] is a class that contains the different states of the sign up process.
/// It is used to update the UI based on the state of the sign up process.
/// It extends [Equatable] to compare the objects.
/// The different states are:
/// - [SignUpInitial]: The initial state of the sign up process.
/// - [SignUpLoading]: The state when the sign up process is in progress.
/// - [SignUpSuccess]: The state when the sign up process is successful.
/// - [SignUpFailure]: The state when the sign up process fails.

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserEntity user;

  const SignUpSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
