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
    apiKey: 'AIzaSyDXz1kig2H1aEHb0QK8141_IMon44p4i1M',
    appId: '1:152102349820:web:fd845b71d2f6276291e079',
    messagingSenderId: '152102349820',
    projectId: 'dio-tik-tok-clone',
    authDomain: 'dio-tik-tok-clone.firebaseapp.com',
    storageBucket: 'dio-tik-tok-clone.appspot.com',
    measurementId: 'G-9TV6Q1Q3RT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmnu6C0ydAhExjw0a9-68W15csOJ-yXxg',
    appId: '1:152102349820:android:54d0caf1d2e55a1391e079',
    messagingSenderId: '152102349820',
    projectId: 'dio-tik-tok-clone',
    storageBucket: 'dio-tik-tok-clone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaMFZNkh_O0OskOkvhgNsjTTw2KEGJ2QM',
    appId: '1:152102349820:ios:a80d4be7de6dfbdf91e079',
    messagingSenderId: '152102349820',
    projectId: 'dio-tik-tok-clone',
    storageBucket: 'dio-tik-tok-clone.appspot.com',
    iosBundleId: 'kr.jonghyun.tiktok',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaMFZNkh_O0OskOkvhgNsjTTw2KEGJ2QM',
    appId: '1:152102349820:ios:cd8c0b84341b2d9d91e079',
    messagingSenderId: '152102349820',
    projectId: 'dio-tik-tok-clone',
    storageBucket: 'dio-tik-tok-clone.appspot.com',
    iosBundleId: 'kr.jonghyun.tiktok.RunnerTests',
  );
}
