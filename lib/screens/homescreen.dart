import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/screens/profile_public.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/category_tile.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import 'loading_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const HomeScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const HomeScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class HomeScreenAndroid extends StatefulWidget {
  const HomeScreenAndroid({super.key});

  @override
  State<HomeScreenAndroid> createState() => _HomeScreenAndroidState();
}

class _HomeScreenAndroidState extends State<HomeScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: double.infinity,
                height: 600,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/home.jpg',
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    ),
                    const Divider(
                      thickness: 3,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Discover new art and artists',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Browse our collection of artists, graphic designers and creators and find new artworks that inspire you',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                                child: decoratedButton(() {
                              pushRoute(context, exploreRoute);
                            }, 'Browse Artwork', 200))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Featured',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onTap: () {
                              pushRoute(context, postRoute);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                artCard(post['imagePath']),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Top Artists',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 360,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else {
                        final users = snapshot.data!.docs;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return PublicProfile(
                                      artistEmail: user['email'],
                                    );
                                  }),
                                );
                              },
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  artistCard(
                                      user['imagePath'], user['username']),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  )),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Trending',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onTap: () {
                              pushRoute(context, postRoute);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                artCard(post['imagePath']),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'On Sale',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onTap: () {
                              pushRoute(context, postRoute);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                artCard(post['imagePath']),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Budget Finds',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return GestureDetector(
                            onTap: () {
                              pushRoute(context, postRoute);
                            },
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                artCard(post['imagePath']),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoryTileWidget('Digital Art', Colors.deepOrangeAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Sketches', Colors.lightBlueAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Anime', Colors.green),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Contemporary', Colors.redAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Cultural', Colors.purpleAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Paintings', Colors.blueAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Abstract', Colors.pinkAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  categoryTileWidget('Comics or Manga', Colors.tealAccent),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/home.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 3,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(60),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Discover new art and artists',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Browse our collection of artists, graphic designers and creators and find new artworks that inspire you',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.grey),
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                                child: decoratedButton(
                                    () {}, 'Browse Artwork', 250)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Featured',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              artCard(post['imagePath']),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Top Artists',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 360,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else {
                        final users = snapshot.data!.docs;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                artistCard(user['imagePath'], user['username']),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Trending',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              artCard(post['imagePath']),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'On Sale',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              artCard(post['imagePath']),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Budget Finds',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    } else {
                      final posts = snapshot.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              artCard(post['imagePath']),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const Divider(thickness: 3),
            ],
          ),
        ),
      ),
    );
  }
}

Widget artCard(String imagePath) {
  return SizedBox(
    width: 300,
    child: SizedBox(
      height: 300,
      width: 300,
      child: Image.network(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget artistCard(String imagePath, String name) {
  return SizedBox(
    width: 300,
    child: Column(
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, elevation: 0),
              child: const Text('Follow'),
            )
          ],
        )
      ],
    ),
  );
}
