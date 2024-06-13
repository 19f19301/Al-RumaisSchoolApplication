import 'package:flutter/material.dart';
import 'package:school/auth/signIn.dart';
import 'package:school/auth/signup.dart';
import 'package:school/home/home.dart';
import 'package:school/screens/menu.dart';
import 'package:school/screens/pageviews.dart';
import 'package:school/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the generated file
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  // await Firebase.initializeApp(
  //    options: const FirebaseOptions(
  //           apiKey: "AIzaSyCyDJuLQUlYzAFkgdwm0ZQTW1jHnOI-Lk8",
  //           appId: "1:1000157206735:android:c2894d313f98442ade3fba",
  //           messagingSenderId: "1000157206735",
  //           projectId: "school-d8f0f",
  //         ),
  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
  
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? const  Menu()
          : const Splash(),
      // initialRoute: '/splash',
      routes: {
        '/splash': (context) => const Splash(),
        '/views': (context) => const PageViews(),
        '/signIn': (context) => const SignIn(),
        '/signUp': (context) => const SignUp(),
        '/menu': (context) => const Menu(),
        '/home': (context) => const Home()
      },
    );
  }
}
