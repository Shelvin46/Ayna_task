import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/repositories/login_repo.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoginUsecases {
  Future<Either<Failure, UserEntity>> executeLogin(
      UserEntity userEntity) async {
    return await locator<LoginRepo>().login(userEntity);
  }
}
