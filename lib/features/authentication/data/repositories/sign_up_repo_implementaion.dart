import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/authentication/domain/repositories/sign_up_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpRepoImplementation implements SignUpRepo {
  @override
  Future<Either<Failure, UserEntity>> signUp(UserEntity userEntity) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
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
