import 'dart:async';
import 'dart:io';

import 'package:ayna_task/core/failures/failures.dart';

///[CustomExceptionHandler] is a class that handles exceptions and returns a [Failure] object
///It has a static method [handleException] that takes an exception and returns a [Failure] object
///It checks the type of the exception and returns a specific [Failure] object
///
class CustomExceptionHandler implements Exception {
  static Failure handleException(e) {
    if (e is TimeoutException) {
      return const CustomTimeoutException(
        message: "Timeout! Please try again later.",
      );
    } else if (e is FormatException) {
      return const ParsingException(
        message: "Parsing Error!",
      );
    } else if (e is HttpException) {
      return const APIException(
        message: "Invalid Request!",
      );
    } else if (e is SocketException) {
      return const NetworkException(
        message: "Check your internet connection",
      );
    } else {
      return const Failure(
        message: "An error occurred try again later.",
      );
    }
  }
}

///[FirebaseAuthExceptionFailure] is a class that extends [Failure] class
///It has a constructor that takes a message
///It has a static method [fromCode] that takes a code and returns a specific [Failure] object

class FirebaseAuthExceptionFailure extends Failure {
  const FirebaseAuthExceptionFailure({required super.message});

  static Failure fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const FirebaseAuthExceptionFailure(
            message: 'The email address is badly formatted.');
      case 'user-disabled':
        return const FirebaseAuthExceptionFailure(
            message: 'The user account has been disabled by an administrator.');
      case 'user-not-found':
        return const FirebaseAuthExceptionFailure(
            message:
                'There is no user record corresponding to this identifier. The user may have been deleted.');
      case 'wrong-password':
        return const FirebaseAuthExceptionFailure(
            message:
                'The password is invalid or the user does not have a password.');
      case 'email-already-in-use':
        return const FirebaseAuthExceptionFailure(
            message: 'The email address is already in use by another account.');
      case 'operation-not-allowed':
        return const FirebaseAuthExceptionFailure(
            message: 'Email/password accounts are not enabled.');
      case 'weak-password':
        return const FirebaseAuthExceptionFailure(
            message: 'The password provided is too weak.');
      case 'invalid-credential':
        return const FirebaseAuthExceptionFailure(
            message:
                'User not found. Please sign up or verify your email address.');
      default:
        return const FirebaseAuthExceptionFailure(
            message: 'An undefined Error happened try again later.');
    }
  }
}
