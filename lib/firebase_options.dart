// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA7hOhRvOkGcCzvzswuNUG0sdpx0biAI7w',
    appId: '1:711660053537:web:5f430f7058522e9b2c2f60',
    messagingSenderId: '711660053537',
    projectId: 'mow-app-e0be2',
    authDomain: 'mow-app-e0be2.firebaseapp.com',
    databaseURL: 'https://mow-app-e0be2-default-rtdb.firebaseio.com',
    storageBucket: 'mow-app-e0be2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkL4yFSa3vO2BLsZUR_BMmz3VXsFzXTZU',
    appId: '1:711660053537:android:80c674721b5cf9ce2c2f60',
    messagingSenderId: '711660053537',
    projectId: 'mow-app-e0be2',
    databaseURL: 'https://mow-app-e0be2-default-rtdb.firebaseio.com',
    storageBucket: 'mow-app-e0be2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAViMoJoH9d3fhkha7gskDL-Re9G6cikcg',
    appId: '1:711660053537:ios:44b08dd3c8c46a3f2c2f60',
    messagingSenderId: '711660053537',
    projectId: 'mow-app-e0be2',
    databaseURL: 'https://mow-app-e0be2-default-rtdb.firebaseio.com',
    storageBucket: 'mow-app-e0be2.appspot.com',
    iosClientId: '711660053537-1r54os2us3kimad1alfe2ci3mrrr0r3a.apps.googleusercontent.com',
    iosBundleId: 'com.example.mow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAViMoJoH9d3fhkha7gskDL-Re9G6cikcg',
    appId: '1:711660053537:ios:44b08dd3c8c46a3f2c2f60',
    messagingSenderId: '711660053537',
    projectId: 'mow-app-e0be2',
    databaseURL: 'https://mow-app-e0be2-default-rtdb.firebaseio.com',
    storageBucket: 'mow-app-e0be2.appspot.com',
    iosClientId: '711660053537-1r54os2us3kimad1alfe2ci3mrrr0r3a.apps.googleusercontent.com',
    iosBundleId: 'com.example.mow',
  );
}
