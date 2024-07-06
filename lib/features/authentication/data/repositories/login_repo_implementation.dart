import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

///[LoginRepoImplementation] is a class that implements [LoginRepo]
///It has a method [login] that takes a [UserEntity] object and returns [Either<Failure, UserEntity>]
///If the login is successful, it returns [Right<UserEntity>]
///If the login fails, it returns [Left<Failure>]
class LoginRepoImplementation implements LoginRepo {
  @override
  Future<Either<Failure, UserEntity>> login(UserEntity userEntity) async {
    try {
      // Attempt to sign in with email and password
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password,
      );

      // If the user is not verified, send a verification email
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        return const Left(Failure(message: "Please verify your email"));
      } else {
        // create a UserEntity object with the email, password and token

        final entity = UserEntity(
          email: userEntity.email,
          password: userEntity.password,
          token: user?.uid ?? '',
        );
        // If the token is empty, return a failure
        if (entity.token.isEmpty) {
          return const Left(Failure(
            message: "Couldn't get the credentials try again later,",
          ));
        } else {
          return Right(entity);
        }
      }
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthExceptionFailure.fromCode(e.code));
    } catch (e) {
      return Left(CustomExceptionHandler.handleException(e));
    }
  }
}
