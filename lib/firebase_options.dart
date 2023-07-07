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
    apiKey: 'AIzaSyDqtj9P7_Xb_MsDSZyGQiAOtsfRJf8Cx-4',
    appId: '1:963822782814:web:c01ff8947227baec8627cf',
    messagingSenderId: '963822782814',
    projectId: 'chatapp-ceb11',
    authDomain: 'chatapp-ceb11.firebaseapp.com',
    storageBucket: 'chatapp-ceb11.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpBLhYpto860PwpNMM33IrPJ7NEpWKOkU',
    appId: '1:963822782814:android:1e2f322ef41085818627cf',
    messagingSenderId: '963822782814',
    projectId: 'chatapp-ceb11',
    storageBucket: 'chatapp-ceb11.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASukCFQqEbIM-G7MjE1JMhSrzw9Wn1iVI',
    appId: '1:963822782814:ios:42b0f1fe11e5c3468627cf',
    messagingSenderId: '963822782814',
    projectId: 'chatapp-ceb11',
    storageBucket: 'chatapp-ceb11.appspot.com',
    iosClientId: '963822782814-1regup4blupuckcq6sdps2kpqut83p7a.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASukCFQqEbIM-G7MjE1JMhSrzw9Wn1iVI',
    appId: '1:963822782814:ios:a69885f650b1a3d88627cf',
    messagingSenderId: '963822782814',
    projectId: 'chatapp-ceb11',
    storageBucket: 'chatapp-ceb11.appspot.com',
    iosClientId: '963822782814-jcrr0i9nvi4ihck0coockq7dcibn49b6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatapp.RunnerTests',
  );
}