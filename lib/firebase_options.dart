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
    apiKey: 'AIzaSyB92G9INq_J0B3RNodfm37CzjWLiJyzbRM',
    appId: '1:928369675329:web:be663f743bf4d5f6e60ac0',
    messagingSenderId: '928369675329',
    projectId: 'whats-app-project-a71e5',
    authDomain: 'whats-app-project-a71e5.firebaseapp.com',
    storageBucket: 'whats-app-project-a71e5.appspot.com',
    measurementId: 'G-SFSF7XGJEF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFovn0ZDyqiHhUmuceZ8MPKgU8qbj6RfI',
    appId: '1:928369675329:android:96c5505cff4cecf7e60ac0',
    messagingSenderId: '928369675329',
    projectId: 'whats-app-project-a71e5',
    storageBucket: 'whats-app-project-a71e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBX2jjljbh0VYqkEHns_Wb2tAweDT7REj8',
    appId: '1:928369675329:ios:dd6fd00387d56ee1e60ac0',
    messagingSenderId: '928369675329',
    projectId: 'whats-app-project-a71e5',
    storageBucket: 'whats-app-project-a71e5.appspot.com',
    iosBundleId: 'com.example.mentorwhatsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBX2jjljbh0VYqkEHns_Wb2tAweDT7REj8',
    appId: '1:928369675329:ios:dd6fd00387d56ee1e60ac0',
    messagingSenderId: '928369675329',
    projectId: 'whats-app-project-a71e5',
    storageBucket: 'whats-app-project-a71e5.appspot.com',
    iosBundleId: 'com.example.mentorwhatsapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB92G9INq_J0B3RNodfm37CzjWLiJyzbRM',
    appId: '1:928369675329:web:3669dee18de41df3e60ac0',
    messagingSenderId: '928369675329',
    projectId: 'whats-app-project-a71e5',
    authDomain: 'whats-app-project-a71e5.firebaseapp.com',
    storageBucket: 'whats-app-project-a71e5.appspot.com',
    measurementId: 'G-PMZDR9HMWS',
  );
}
