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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBdxLOrAHMZaZDybFGFRpXaoAO6D1nN9jA',
    appId: '1:994940070419:web:3e449e8b0ca1f81cbfade6',
    messagingSenderId: '994940070419',
    projectId: 'art-wave-172cf',
    authDomain: 'art-wave-172cf.firebaseapp.com',
    storageBucket: 'art-wave-172cf.appspot.com',
    measurementId: 'G-L1CP9MEEWG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhuqU4Zzafq7ZDTNy601b6XgL8Q5GseTQ',
    appId: '1:994940070419:android:c6cf8386ded02f3bbfade6',
    messagingSenderId: '994940070419',
    projectId: 'art-wave-172cf',
    storageBucket: 'art-wave-172cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1BzAn3j7YKJYVRLe9-n-a4YgssgXXIOM',
    appId: '1:994940070419:ios:72fc3dcf74cc395cbfade6',
    messagingSenderId: '994940070419',
    projectId: 'art-wave-172cf',
    storageBucket: 'art-wave-172cf.appspot.com',
    iosBundleId: 'com.example.artWave',
  );
}