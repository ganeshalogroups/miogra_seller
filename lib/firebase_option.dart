import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyBTH7k58IhNJRckHPz3eBHQf11L2Oa1j5M',
      appId: '1:944429639165:android:bdf056bfd24d28dc74e594',
      messagingSenderId: '944429639165',
      projectId: 'kipgra-472312',
      storageBucket: 'kipgra-472312.firebasestorage.app',
      iosClientId: 'your-ios-client-id',
      androidClientId: 'your-android-client-id',
      iosBundleId: 'your-ios-bundle-id',
    );
  }
}