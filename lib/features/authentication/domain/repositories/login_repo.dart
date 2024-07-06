import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

/// [LoginRepo] is an abstract class that has a method called [login] that takes a [UserEntity] as
/// a parameter and returns a [Future] of [Either] of [Failure] and [UserEntity].
/// It is used to login the user.
abstract class LoginRepo {
  Future<Either<Failure, UserEntity>> login(UserEntity userEntity);
}
