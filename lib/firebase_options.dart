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
    apiKey: 'AIzaSyCuIk-AdV28daccfdOs2gVs6JvepP4bQh4',
    appId: '1:161268884450:web:696cc31314cf3185a0cfbb',
    messagingSenderId: '161268884450',
    projectId: 'notetedd',
    authDomain: 'notetedd.firebaseapp.com',
    storageBucket: 'notetedd.appspot.com',
    measurementId: 'G-19DFXVTES7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_0vMABd4QGno8QTuYBSukDkLe1nEZxhI',
    appId: '1:161268884450:android:c884aef5bdb29f1aa0cfbb',
    messagingSenderId: '161268884450',
    projectId: 'notetedd',
    storageBucket: 'notetedd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-xKfBkDhzthIhOiezfeJoGM5oyDxp4u8',
    appId: '1:161268884450:ios:02fecbc9a471a901a0cfbb',
    messagingSenderId: '161268884450',
    projectId: 'notetedd',
    storageBucket: 'notetedd.appspot.com',
    iosBundleId: 'com.notetedd.noteTedd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-xKfBkDhzthIhOiezfeJoGM5oyDxp4u8',
    appId: '1:161268884450:ios:02fecbc9a471a901a0cfbb',
    messagingSenderId: '161268884450',
    projectId: 'notetedd',
    storageBucket: 'notetedd.appspot.com',
    iosBundleId: 'com.notetedd.noteTedd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCuIk-AdV28daccfdOs2gVs6JvepP4bQh4',
    appId: '1:161268884450:web:653b00c27d929f98a0cfbb',
    messagingSenderId: '161268884450',
    projectId: 'notetedd',
    authDomain: 'notetedd.firebaseapp.com',
    storageBucket: 'notetedd.appspot.com',
    measurementId: 'G-S6KQFLEVVK',
  );
}
