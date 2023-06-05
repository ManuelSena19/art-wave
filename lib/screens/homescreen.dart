import 'package:art_wave/utilities/category_tile.dart';
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
        title: const Text(
          'Art Wave',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoryTileWidget('Digital Art', Colors.deepOrangeAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Sketches', Colors.lightBlueAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Anime', Colors.green),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Contemporary', Colors.redAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('NFTs', Colors.orangeAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Cultural', Colors.purpleAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Paintings', Colors.blueAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Abstract', Colors.pinkAccent),
                  const SizedBox(width: 10,),
                  categoryTileWidget('Decoration', Colors.tealAccent),
                  const SizedBox(width: 10,),
                ],
              ),
              const SizedBox(height: 30,),
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
              const Text('Featured', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 400,
              ),
              const Divider(thickness: 3),
              const Text('Top Artists', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 400,
              ),
              const Divider(thickness: 3),
            ],
          ),
        ),
      ),
    );
  }
}
