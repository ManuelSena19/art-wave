import 'package:art_wave/utilities/category_tile.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ClipOval(child: Image.asset('logo.png', fit: BoxFit.fill, height: 45, width: 50,)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                  categoryTileWidget('NFTs', Colors.orangeAccent),
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
                  categoryTileWidget('Decoration', Colors.tealAccent),
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
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.lightBlueAccent,
                                        Colors.orangeAccent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Browse Artworks',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard()
                  ],
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
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artistCard()
                  ],
                ),
              ),
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
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard()
                  ],
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
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard()
                  ],
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
                height: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard(),
                    const SizedBox(
                      width: 25,
                    ),
                    artCard()
                  ],
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

Widget artCard() {
  return SizedBox(
    width: 300,
    child: Column(
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(
            "assets/no_photo.jpg",
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Title',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "0.00",
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Artist',
          style: TextStyle(color: Colors.orangeAccent, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget artistCard() {
  return SizedBox(
    width: 300,
    child: Column(
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(
            "assets/user.jpg",
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                Text('Name'),
                SizedBox(
                  height: 25,
                ),
                Text('Rating'),
              ],
            ),
            Expanded(child: Container()),
            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), child: const Text('Follow'),)
          ],
        )
      ],
    ),
  );
}
