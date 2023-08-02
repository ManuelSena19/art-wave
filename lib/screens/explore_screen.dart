import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/is_android.dart';
import 'loading_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const ExploreScreenWeb();
    } else {
      if (isAndroid()) {
        return const ExploreScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class ExploreScreenWeb extends StatefulWidget {
  const ExploreScreenWeb({super.key});

  @override
  State<ExploreScreenWeb> createState() => _ExploreScreenWebState();
}

class _ExploreScreenWebState extends State<ExploreScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExploreScreenAndroid extends StatefulWidget {
  const ExploreScreenAndroid({super.key});

  @override
  State<ExploreScreenAndroid> createState() => _ExploreScreenAndroidState();
}

class _ExploreScreenAndroidState extends State<ExploreScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 600,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
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
      ),
    );
  }
}
