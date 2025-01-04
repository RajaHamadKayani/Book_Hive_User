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
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for macos - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.windows:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for windows - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDL60P5JiS9hDvwMQmyZSKkqThyjUFQwXI",
      authDomain: "bookhive-d99ff.firebaseapp.com",
      projectId: "bookhive-d99ff",
      storageBucket: "bookhive-d99ff.firebasestorage.app",
      messagingSenderId: "401459819675",
      appId: "1:401459819675:web:be88d45f9b085b6725823e",
      measurementId: "G-J067MG58K6");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDL60P5JiS9hDvwMQmyZSKkqThyjUFQwXI',
    appId: '1:401459819675:android:4612c7b20e7afb0825823e',
    messagingSenderId: '401459819675',
    projectId: 'bookhive-d99ff',
    storageBucket: 'bookhive-d99ff.firebasestorage.app',
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyDqCVsA1-xlHgNDhtSHpvI4qRM98zVBgOA',
  //   appId: '1:545059185697:ios:45f15c5756e4e9eda9af60',
  //   messagingSenderId: '545059185697',
  //   projectId: 'healthful-dev',
  //   storageBucket: 'healthful-dev.firebasestorage.app',
  //   iosBundleId: 'com.hifah.healthful',
  // );
}
