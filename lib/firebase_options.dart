import 'package:firebase_core/firebase_core.dart' show FirebaseOptions; // Mengimpor FirebaseOptions dari firebase_core
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb; // Mengimpor platform dan variabel terkait

class DefaultFirebaseOptions {
  // Mendefinisikan class DefaultFirebaseOptions untuk mengelola konfigurasi Firebase berdasarkan platform

  static FirebaseOptions get currentPlatform {
    // Mengembalikan FirebaseOptions yang sesuai dengan platform saat ini
    if (kIsWeb) {
      return web; // Mengembalikan opsi untuk web
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android; // Mengembalikan opsi untuk Android
      case TargetPlatform.iOS:
        return ios; // Mengembalikan opsi untuk iOS
      case TargetPlatform.macOS:
        return macos; // Mengembalikan opsi untuk macOS
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.', // Menangani platform yang tidak didukung
        );
    }
  }

  // Konfigurasi Firebase untuk web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "YOUR_WEB_API_KEY", // Kunci API untuk web
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com", // Domain otentikasi
    projectId: "YOUR_PROJECT_ID", // ID proyek Firebase
    storageBucket: "YOUR_PROJECT_ID.appspot.com", // Bucket penyimpanan
    messagingSenderId: "YOUR_SENDER_ID", // ID pengirim pesan
    appId: "YOUR_WEB_APP_ID", // ID aplikasi web
    measurementId: "YOUR_MEASUREMENT_ID", // ID pengukuran
  );

  // Konfigurasi Firebase untuk Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "", // Kunci API untuk Android
    appId: "", // ID aplikasi Android
    messagingSenderId: "", // ID pengirim pesan
    projectId: "", // ID proyek Firebase
    storageBucket: "", // Bucket penyimpanan
  );

  // Konfigurasi Firebase untuk iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "", // Kunci API untuk iOS
    appId: "", // ID aplikasi iOS
    messagingSenderId: "", // ID pengirim pesan
    projectId: "", // ID proyek Firebase
    storageBucket: "", // Bucket penyimpanan
    iosClientId: "", // ID klien iOS
    iosBundleId: "", // Bundle ID iOS
  );

  // Konfigurasi Firebase untuk macOS
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "", // Kunci API untuk macOS
    appId: "", // ID aplikasi macOS
    messagingSenderId: "", // ID pengirim pesan
    projectId: "", // ID proyek Firebase
    storageBucket: "", // Bucket penyimpanan
    iosClientId: "", // ID klien iOS
    iosBundleId: "", // Bundle ID iOS
  );
}