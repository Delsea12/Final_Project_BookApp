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
    apiKey: 'AIzaSyC19vOENGSb8rt6GP0wx84p1zmlyXAid8w',
    appId: '1:260243643351:web:e60546a895af5b1285c992',
    messagingSenderId: '260243643351',
    projectId: 'books-app-28d0c',
    authDomain: 'books-app-28d0c.firebaseapp.com',
    storageBucket: 'books-app-28d0c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH4Sv988IUbgbRov-biqMHtJl_tWon8J8',
    appId: '1:260243643351:android:a997c654dbd4dee285c992',
    messagingSenderId: '260243643351',
    projectId: 'books-app-28d0c',
    storageBucket: 'books-app-28d0c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgGGCWqBDjqn1krPsDgs0InDK-iB01nvM',
    appId: '1:260243643351:ios:5501781cb40b397885c992',
    messagingSenderId: '260243643351',
    projectId: 'books-app-28d0c',
    storageBucket: 'books-app-28d0c.appspot.com',
    iosBundleId: 'com.example.simpleBooksApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgGGCWqBDjqn1krPsDgs0InDK-iB01nvM',
    appId: '1:260243643351:ios:5501781cb40b397885c992',
    messagingSenderId: '260243643351',
    projectId: 'books-app-28d0c',
    storageBucket: 'books-app-28d0c.appspot.com',
    iosBundleId: 'com.example.simpleBooksApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC19vOENGSb8rt6GP0wx84p1zmlyXAid8w',
    appId: '1:260243643351:web:2f362edd72f8aa3385c992',
    messagingSenderId: '260243643351',
    projectId: 'books-app-28d0c',
    authDomain: 'books-app-28d0c.firebaseapp.com',
    storageBucket: 'books-app-28d0c.appspot.com',
  );
}
