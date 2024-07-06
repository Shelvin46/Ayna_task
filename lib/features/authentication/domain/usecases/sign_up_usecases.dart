import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/repositories/sign_up_repo.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:dartz/dartz.dart';

///[SignUpUseCases] is a class that executes the sign up process
///It takes a [UserEntity] object and calls [SignUpRepo] to sign up the user
///It returns [Either<Failure, UserEntity>]
///If the sign up is successful, it returns [Right<UserEntity>]
///If the sign up fails, it returns [Left<Failure>]
///It also has a method to store the user information in the database

class SignUpUseCases {
  Future<Either<Failure, UserEntity>> executeSignUp(
      UserEntity userEntity) async {
    return await locator<SignUpRepo>().signUp(userEntity);
  }

  Future<Either<Failure, UserEntity>> executeUserInfoStore(
      {required UserEntity userEntity}) async {
    return await locator<SignUpRepo>().storeUserInfo(userEntity: userEntity);
  }
}
