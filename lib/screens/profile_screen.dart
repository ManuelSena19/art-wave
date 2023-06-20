import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/user_data.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

String _email = FirebaseAuth.instance.currentUser!.email.toString();

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
  void onPressed() {
    pushReplacementRoute(context, editProfileRoute);
  }

  Future<void Function()?> openLink(String link) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $link';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(_email),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final String? name = userData['username'] as String?;
          final String? website = userData['website'] as String?;
          final int? followers = userData['followers'] as int?;
          final int? following = userData['following'] as int?;
          int posts = 0;
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
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
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
            return Scaffold(
              appBar: appbarWidget(context),
              drawer: drawerWidget(context),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 300),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            ClipOval(
                              child: Image.network(
                                imagePath!,
                                height: 200,
                                width: 200,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _email,
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    decoratedButton(
                                        onPressed, 'Edit Profile', 120),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '$posts posts',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      '$followers followers',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      '$following following',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  name!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.link,
                                      color: Colors.grey,
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          await openLink(website);
                                        },
                                        child: Text(website!)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  about!,
                                  style: const TextStyle(fontSize: 15),
                                  maxLines: 5,
                                  softWrap: true,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Divider(thickness: 3),
                        Padding(
                          padding: const EdgeInsets.all(100),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                size: 100,
                                color: Colors.grey,
                              ),
                              const Text(
                                "Share your Art",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "When you share your creations, they would appear here",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              decoratedButton(() {}, "Post Artwork", 150),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
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
