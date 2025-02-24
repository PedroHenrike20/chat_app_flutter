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
    apiKey: 'AIzaSyDv3J-uXf0bMpW0skWxiNZP7m2TQ66hYPA',
    appId: '1:435664990943:web:15ad964eae32a862342f6a',
    messagingSenderId: '435664990943',
    projectId: 'chat-flutterapp-c788a',
    authDomain: 'chat-flutterapp-c788a.firebaseapp.com',
    storageBucket: 'chat-flutterapp-c788a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_z8bYu4U7WjFvcj7Gg1qjt1dMmzjCl4U',
    appId: '1:435664990943:android:04e623adeddc306c342f6a',
    messagingSenderId: '435664990943',
    projectId: 'chat-flutterapp-c788a',
    storageBucket: 'chat-flutterapp-c788a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF9PrOrznDwrYdhwvTcBoyT9MUnqDAPhM',
    appId: '1:435664990943:ios:859bbaeb772b7230342f6a',
    messagingSenderId: '435664990943',
    projectId: 'chat-flutterapp-c788a',
    storageBucket: 'chat-flutterapp-c788a.appspot.com',
    iosClientId: '435664990943-jru8mt46jvqmt9bpdjujccisn5qa33vk.apps.googleusercontent.com',
    iosBundleId: 'br.com.pedrodev.chatflutter',
  );
}
