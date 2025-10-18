import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAwnCF5vl1_qriJOPPADLF5jdsCqjKTtYA",
            authDomain: "onemanengine-9c23b.firebaseapp.com",
            projectId: "onemanengine-9c23b",
            storageBucket: "onemanengine-9c23b.firebasestorage.app",
            messagingSenderId: "616436705273",
            appId: "1:616436705273:web:f211c1361e7baf6af37f28",
            measurementId: "G-5GB870J343"));
  } else {
    await Firebase.initializeApp();
  }
}
