import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/user_data.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

String _email = FirebaseAuth.instance.currentUser!.email.toString();

Future<void Function()?> openLink(String link) async {
  final Uri url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.platformDefault);
  } else {
    throw 'Could not launch $link';
  }
  return null;
}

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
                                fit: BoxFit.fill,
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
                              decoratedButton(() {
                                pushRoute(context, createRoute);
                              }, "Post Artwork", 150),
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
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(_email),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final String name = userData['username'] as String? ?? 'name';
          final String website = userData['website'] as String? ?? 'website';
          final List<dynamic>? followers =
              userData['followers'] as List<dynamic>?;
          final int followerCount = followers?.length ?? 0;
          final List<dynamic>? following =
              userData['following'] as List<dynamic>?;
          final int followingCount = following?.length ?? 0;
          final String about = userData['about'] as String? ?? "about";
          final String imagePath = userData['imagePath'] as String? ??
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4R9w1OwQjbnun15jlbPEDqicrbEsAnBeSQOFpvuEE2A&s';
          if (about == "") {
            return Material(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 300, horizontal: 100),
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
                padding: const EdgeInsets.all(15),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        Text(
                          _email,
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {
                            pushReplacementRoute(context, createRoute);
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: getArtistPostCount(_email),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LoadingScreen();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    int postCount = snapshot.data ?? 0;
                                    return Text('$postCount');
                                  }
                                },
                              ),
                              const Text('posts'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text('$followingCount'),
                              const Text('following')
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Text('$followerCount'),
                              const Text('followers')
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    website != ""
                        ? Row(
                            children: [
                              const Icon(
                                Icons.link,
                                color: Colors.grey,
                              ),
                              TextButton(
                                onPressed: () {
                                  openLink(website);
                                },
                                child: Text(website),
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 1,
                          ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      about,
                      style: const TextStyle(fontSize: 15),
                      maxLines: 5,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                elevation: 0),
                            onPressed: () {
                              pushReplacementRoute(context, editProfileRoute);
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange, elevation: 0),
                            onPressed: () {},
                            child: const Text(
                              'Messages',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    FutureBuilder<int>(
                      future: getArtistPostCount(_email),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingScreen();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          int postCount = snapshot.data ?? 0;
                          if (postCount == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(60),
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
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "When you share your creations, they would appear here",
                                    style: TextStyle(fontSize: 20),
                                    softWrap: true,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  decoratedButton(() {
                                    pushRoute(context, createRoute);
                                  }, "Post Artwork", 150),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Center(
                                    child: Icon(Icons.photo_album_outlined),
                                  ),
                                  SizedBox(
                                    height: 400,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('posts')
                                          .where('artist', isEqualTo: _email)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const LoadingScreen();
                                        } else {
                                          final posts = snapshot.data!.docs;
                                          return GridView.builder(
                                            itemCount: posts.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 8.0,
                                              crossAxisSpacing: 8.0,
                                            ),
                                            itemBuilder: (context, index) {
                                              final post = posts[index];
                                              final imagePath =
                                                  post['imagePath'] as String?;
                                              if (imagePath != null) {
                                                return Image.network(
                                                  imagePath,
                                                  fit: BoxFit.cover,
                                                );
                                              } else {
                                                return const Placeholder();
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Text("Check your network connection");
        }
      },
    );
  }
}
