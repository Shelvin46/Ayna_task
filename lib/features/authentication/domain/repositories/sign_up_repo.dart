import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

///[SignUpRepo] is an abstract class that has two methods
///[signUp] and [storeUserInfo]
///[signUp] takes a [UserEntity] object and returns [Either<Failure, UserEntity>]
///[storeUserInfo] takes a [UserEntity] object and returns [Either<Failure, UserEntity>]
abstract class SignUpRepo {
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity);

  Future<Either<Failure, UserEntity>> storeUserInfo({
    required UserEntity userEntity,
  });
}
