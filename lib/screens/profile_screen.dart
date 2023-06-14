import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/user_data.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const ProfileScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const ProfileScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class ProfileScreenWeb extends StatefulWidget {
  const ProfileScreenWeb({super.key});

  @override
  State<ProfileScreenWeb> createState() => _ProfileScreenWebState();
}

class _ProfileScreenWebState extends State<ProfileScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future:
            getUserData(FirebaseAuth.instance.currentUser!.email.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            final String? about = userData['about'] as String?;
            final String? imagePath = userData['imagePath'] as String?;
            if (about == "" && imagePath == "") {
              return Material(
                child: Container(
                  padding: const EdgeInsets.all(300),
                  width: 50,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        "Click on the button to create your public profile",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        softWrap: true,
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          foregroundColor: Colors.black
                        ),
                        onPressed: () {
                          pushReplacementRoute(context, editProfileRoute);
                        },
                        child: const Text('Create'),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Placeholder();
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text("Check your network connection");
          }
        },
      );
  }
}

class ProfileScreenAndroid extends StatefulWidget {
  const ProfileScreenAndroid({super.key});

  @override
  State<ProfileScreenAndroid> createState() => _ProfileScreenAndroidState();
}

class _ProfileScreenAndroidState extends State<ProfileScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
