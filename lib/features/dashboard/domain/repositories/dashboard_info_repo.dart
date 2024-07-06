import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardInfoRepo {
  Future<Either<Failure, String>> getDashboardInfo(UserEntity userEntity);
}
