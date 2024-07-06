// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBU9nH-JgA3f4THYAaYRcgHUVL9BRLlIuk',
    appId: '1:144365255659:web:9d6f00269bb7ba5c9a37ae',
    messagingSenderId: '144365255659',
    projectId: 'ayna-3d195',
    authDomain: 'ayna-3d195.firebaseapp.com',
    storageBucket: 'ayna-3d195.appspot.com',
    measurementId: 'G-947KPKZPVC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbfmTaPbwR-tCS4BLVe_9Z0rMu5BvtZGc',
    appId: '1:144365255659:android:ac29033b8e82a8129a37ae',
    messagingSenderId: '144365255659',
    projectId: 'ayna-3d195',
    storageBucket: 'ayna-3d195.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjra9Sj5wZbU1-zUvx9rtp8mph31V2_qo',
    appId: '1:144365255659:ios:bf7fd2a541c49f9d9a37ae',
    messagingSenderId: '144365255659',
    projectId: 'ayna-3d195',
    storageBucket: 'ayna-3d195.appspot.com',
    iosBundleId: 'com.example.aynaTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjra9Sj5wZbU1-zUvx9rtp8mph31V2_qo',
    appId: '1:144365255659:ios:bf7fd2a541c49f9d9a37ae',
    messagingSenderId: '144365255659',
    projectId: 'ayna-3d195',
    storageBucket: 'ayna-3d195.appspot.com',
    iosBundleId: 'com.example.aynaTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBU9nH-JgA3f4THYAaYRcgHUVL9BRLlIuk',
    appId: '1:144365255659:web:e51239ebb41200a89a37ae',
    messagingSenderId: '144365255659',
    projectId: 'ayna-3d195',
    authDomain: 'ayna-3d195.firebaseapp.com',
    storageBucket: 'ayna-3d195.appspot.com',
    measurementId: 'G-9TFYRV3KYK',
  );
}
