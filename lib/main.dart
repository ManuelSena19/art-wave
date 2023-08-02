import 'package:art_wave/constants/logic.dart';
import 'package:art_wave/screens/explore_screen.dart';
import 'package:art_wave/screens/homescreen.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/screens/login_screen.dart';
import 'package:art_wave/screens/messages_screen.dart';
import 'package:art_wave/screens/post_creation_screen.dart';
import 'package:art_wave/screens/post_viewing_screen.dart';
import 'package:art_wave/screens/profile_editor_screen.dart';
import 'package:art_wave/screens/profile_public.dart';
import 'package:art_wave/screens/profile_screen.dart';
import 'package:art_wave/screens/register_screen.dart';
import 'package:art_wave/screens/report_screen.dart';
import 'package:art_wave/screens/reset_password_screen.dart';
import 'package:art_wave/screens/settings_screen.dart';
import 'package:art_wave/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? loginRoute
          : homescreenRoute,
      routes: {
        homescreenRoute: (context) => const HomeScreen(),
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        logicRoute: (context) => const Logic(),
        resetPasswordRoute: (context) => const ResetPasswordScreen(),
        verifyEmailRoute: (context) => const VerifyEmailScreen(),
        loadingRoute: (context) => const LoadingScreen(),
        profileRoute: (context) => const ProfileScreen(),
        editProfileRoute: (context) => const EditProfile(),
        exploreRoute: (context) => const ExploreScreen(),
        createRoute: (context) => const CreateScreen(),
        messagesRoute: (context) => const MessagesScreen(),
        reportRoute: (context) => const ReportScreen(),
        settingsRoute: (context) => const SettingsScreen(),
        publicProfileRoute: (context) => const PublicProfile(),
        postRoute: (context) => const PostViewer()
      },
      theme: ThemeData(primaryColor: Colors.orange),
      home: const Logic(),
    );
  }
}
