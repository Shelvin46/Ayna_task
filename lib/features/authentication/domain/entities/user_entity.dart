import 'package:equatable/equatable.dart';

/// [UserEntity] is a class that contains the user's email, name, password and token.
/// It is used to represent the user's information.
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
