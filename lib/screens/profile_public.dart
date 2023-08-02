import 'package:art_wave/constants/user_data.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/screens/profile_screen.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import '../constants/is_android.dart';

class PublicProfile extends StatelessWidget {
  final String artistEmail;
  const PublicProfile({super.key, required this.artistEmail});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return PublicProfileWeb(
        artistEmail: artistEmail,
      );
    } else {
      if (isAndroid()) {
        return PublicProfileAndroid(
          artistEmail: artistEmail,
        );
      } else {
        return const Placeholder();
      }
    }
  }
}

class PublicProfileWeb extends StatelessWidget {
  final String artistEmail;
  const PublicProfileWeb({super.key, required this.artistEmail});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PublicProfileAndroid extends StatelessWidget {
  final String artistEmail;
  const PublicProfileAndroid({super.key, required this.artistEmail});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(artistEmail),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;
          final String? name = userData['username'] as String?;
          final String? website = userData['website'] as String?;
          final List<dynamic>? followers =
              userData['followers'] as List<dynamic>?;
          final int followerCount = followers!.length;
          final List<dynamic>? following =
              userData['following'] as List<dynamic>?;
          final int followingCount = following!.length;
          final String? about = userData['about'] as String?;
          final String? imagePath = userData['imagePath'] as String?;
          return Scaffold(
            appBar: appbarWidget(context),
            drawer: drawerWidget(context),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                    artistEmail,
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          imagePath!,
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
                              future: getArtistPostCount(artistEmail),
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
                    name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.link,
                        color: Colors.grey,
                      ),
                      TextButton(
                        onPressed: () {
                          openLink(website);
                        },
                        child: Text(website!),
                      ),
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
                          onPressed: () {},
                          child: const Text(
                            'Follow',
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
                            'Message',
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
                    future: getArtistPostCount(artistEmail),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        int postCount = snapshot.data ?? 0;
                        if (postCount == 0) {
                          return const Padding(
                            padding: EdgeInsets.all(60),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "There are no posts to see",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                        .where('artist', isEqualTo: artistEmail)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
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
                                            return Image.network(
                                              '${post['imagePath']}',
                                              fit: BoxFit.cover,
                                            );
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
        } else {
          return const Text("Check your network connection");
        }
      },
    );
  }
}
