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
    apiKey: 'AIzaSyDxzYhwZ0WcuIEAfX7vcbiRKfBPXYXzI8g',
    appId: '1:360207574107:web:0d5e60224bbf4c69024b7e',
    messagingSenderId: '360207574107',
    projectId: 'tailor-953ac',
    authDomain: 'tailor-953ac.firebaseapp.com',
    storageBucket: 'tailor-953ac.appspot.com',
    measurementId: 'G-8PDHK82MWH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJUJksTAspQf8FBpwGD-mzzrM5VXzhyGI',
    appId: '1:360207574107:android:4c706cfa01264d36024b7e',
    messagingSenderId: '360207574107',
    projectId: 'tailor-953ac',
    storageBucket: 'tailor-953ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAp0TrEpl9K-pQih8oGXI_cx6Aj9JI8qk0',
    appId: '1:360207574107:ios:5f88b29e1c1e3dcf024b7e',
    messagingSenderId: '360207574107',
    projectId: 'tailor-953ac',
    storageBucket: 'tailor-953ac.appspot.com',
    iosBundleId: 'com.tailor.tailor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAp0TrEpl9K-pQih8oGXI_cx6Aj9JI8qk0',
    appId: '1:360207574107:ios:9ff1dd2f39ad0c1a024b7e',
    messagingSenderId: '360207574107',
    projectId: 'tailor-953ac',
    storageBucket: 'tailor-953ac.appspot.com',
    iosBundleId: 'com.tailor.tailor.RunnerTests',
  );
}
