import 'package:equatable/equatable.dart';

/// [UserEntity] is a class that contains the user's email and password.
/// It is used to pass the user's email and password to the [LoginBloc] when the user tries to login.
/// It extends [Equatable] to compare the objects.

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String token;

  const UserEntity({
    this.name = "",
    required this.email,
    required this.password,
    this.token = "",
  });

  @override
  List<Object> get props => [name, email, password, token];
}
