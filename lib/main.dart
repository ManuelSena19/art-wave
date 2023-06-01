import 'package:art_wave/screens/homescreen.dart';
import 'package:art_wave/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Wave',
      debugShowCheckedModeBanner: false,
      routes: {
        homescreenRoute: (context) => const HomeScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
