import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/dashboard/domain/repositories/dashboard_info_repo.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:dartz/dartz.dart';

class DashboardUseCases {
  Future<Either<Failure, String>> executeGetDashboardInfo(
      UserEntity userEntity) async {
    return await locator<DashboardInfoRepo>().getDashboardInfo(userEntity);
  }
}
