import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

///[FirebaseAuthenticationService] is a service class that provides authentication services
///It uses [FirebaseAuth] to authenticate the user
///It uses [User] to get the current user
///It uses [_authStateChangesSubscription] to listen to the authentication state changes

class FirebaseAuthenticationService {
  // Factory constructor to access the singleton instance

  // Initialize and return the FirebaseAuth stream subscription
  StreamSubscription<User?> initialize() {
    return FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  // Sign out the user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
