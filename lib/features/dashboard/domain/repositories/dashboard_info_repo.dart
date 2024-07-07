import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

///[DashboardInfoRepo] is an abstract class that has a method [getDashboardInfo]
///that takes a [UserEntity] object and returns [Either<Failure, String>]
///If the process is successful, it returns [Right<String>]
abstract class DashboardInfoRepo {
  Future<Either<Failure, String>> getDashboardInfo(UserEntity userEntity);
}
