import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/repositories/sign_up_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///[SignUpRepoImplementation] is a class that implements [SignUpRepo]
///It has a method [signUp] that takes a [UserEntity] object and returns [Either<Failure, UserEntity>]
///If the sign up is successful, it returns [Right<UserEntity>]
///If the sign up fails, it returns [Left<Failure>]
class SignUpRepoImplementation implements SignUpRepo {
  @override
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    try {
      // Attempt to create a user with email and password in firebase
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password,
      );
      // If the user is not verified, send a verification email
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return Right(userEntity);
    }
    // Handle exceptions
    on FirebaseAuthException catch (e) {
      return Left(FirebaseAuthExceptionFailure.fromCode(e.code));
    } catch (e) {
      return Left(CustomExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> storeUserInfo(
      {required UserEntity userEntity}) async {
    try {
      // Reference to Firestore
      final usersCollection = FirebaseFirestore.instance.collection(
        'usercollection',
      );
      // Add the user's email and name to the collection
      usersCollection.doc(userEntity.email).set({
        'name': userEntity.name,
      }).then((_) {
        debugPrint("Document added with ID: ${userEntity.email}");
      }).catchError((error) {
        debugPrint("Error adding document: $error");
      });
      return Right(userEntity);
    } catch (e) {
      return Left(CustomExceptionHandler.handleException(e));
    }
  }
}
