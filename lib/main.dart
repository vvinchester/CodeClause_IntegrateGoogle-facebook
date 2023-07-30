import 'package:firebase_authentication/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDlxj-jCOchzQQ7qh2XJXymFLnxjeW9c2c",
          authDomain: "fir-authentication-task2.firebaseapp.com",
          projectId: "fir-authentication-task2",
          storageBucket: "fir-authentication-task2.appspot.com",
          messagingSenderId: "365092049658",
          appId: "1:365092049658:web:3decbebf7142dc9445ef43"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Authenication',
      home: LoginScreen(),
    );
  }
}
