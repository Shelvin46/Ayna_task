import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/dashboard/domain/repositories/dashboard_info_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

/// [DashboardInfoRepoImplementation] is a class that implements [DashboardInfoRepo] abstract class.
/// It is used to get the user's name from Firestore.
/// It has a method called [getDashboardInfo] that returns a [Future] of [Either] of [Failure] and [String].
/// It is used to get the user's name.
/// 'documentId' is the key to get the user's document from Firestore.
/// 'usercollection' is the collection name in Firestore.
/// 'name' is the key to get the user's name from Firestore.

class DashboardInfoRepoImplementation implements DashboardInfoRepo {
  @override
  Future<Either<Failure, String>> getDashboardInfo(
      UserEntity userEntity) async {
    try {
      // Fetch the user document from Firestore using the document ID
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('usercollection')
          .doc(userEntity.email)
          .get();
      // Get the user's name from the document
      final userName = documentSnapshot.data()?['name'] as String?;
      // If the user's name is null, return a failure
      if (userName == null) {
        return const Left(
          Failure(
              message: "Unable to get the user data. Please try again later."),
        );
      }
      // If the user's name is not null, return the user's name
      return Right(userName);
    } catch (e) {
      // If an exception occurs, return a failure
      return Left(CustomExceptionHandler.handleException(e));
    }
  }
}
