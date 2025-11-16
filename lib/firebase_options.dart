import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyAp_tKxCTgu7yj5krpGywwmub7BXzT4YtU",
        authDomain: "kidycare-app.firebaseapp.com",
        projectId: "kidycare-app",
        storageBucket: "kidycare-app.firebasestorage.app",
        messagingSenderId: "483767036764",
        appId: "1:483767036764:web:092793b2ab78044511ef99",
        measurementId: "G-NR8S1F02BL",
      );
    }

    // Solo usamos Web por ahora
    throw UnsupportedError(
      'DefaultFirebaseOptions solo está configurado para Web por ahora.',
    );
  }
}
