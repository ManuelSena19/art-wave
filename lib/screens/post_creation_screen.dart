import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/upload_to_firebase.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/is_android.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
List<String> selectedTags = [];
bool flagWarranty = false;
String? _imagePath;

Future<void> createPost(String name, String artist, String description,
    String imagePath, String price, List<String> tags) async {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');
  await posts.doc(name).set({
    'name': name,
    'artist': artist,
    'description': description,
    'imagePath': imagePath,
    'price': price,
    'tags': tags,
  });
}

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const CreateScreenWeb();
    } else {
      if (isAndroid()) {
        return const CreateScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class CreateScreenWeb extends StatefulWidget {
  const CreateScreenWeb({super.key});

  @override
  State<CreateScreenWeb> createState() => _CreateScreenWebState();
}

class _CreateScreenWebState extends State<CreateScreenWeb> {
  String? tagValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 300),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const Text(
                "Post Your Artwork",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  String url = await uploadPostToFirebaseWeb(context);
                  setState(() {
                    _imagePath = url;
                  });
                },
                child: ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: _imagePath == null
                        ? Image.asset(
                            'assets/no_photo.jpg',
                            height: 500,
                            width: 500,
                          )
                        : Image.network(
                            _imagePath!,
                            height: 500,
                          )),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextField(
                      controller: _nameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Price',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextField(
                      controller: _priceController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Tags',
                      style: TextStyle(fontSize: 15),
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                style: BorderStyle.solid, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            value: selectedTags.isNotEmpty
                                ? selectedTags.elementAt(0)
                                : '',
                            onChanged: (String? newValue) {
                              setState(() {
                                if (selectedTags.contains(newValue)) {
                                  selectedTags.remove(newValue);
                                } else {
                                  if (selectedTags.length < 5) {
                                    selectedTags.add(newValue!);
                                  }
                                }
                              });
                            },
                            items: <String>[
                              '',
                              'Digital Art',
                              'Sketches',
                              'Anime',
                              'Contemporary',
                              'Cultural',
                              'Paintings',
                              'Abstract',
                              'Comics or Manga'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 300,
                                  child: CheckboxListTile(
                                    value: selectedTags.contains(value),
                                    activeColor: Colors.blue,
                                    onChanged: (bool? checked) {
                                      setState(() {
                                        if (selectedTags.contains(value)) {
                                          selectedTags.remove(value);
                                        } else {
                                          if (selectedTags.length < 5) {
                                            selectedTags.add(value);
                                          }
                                        }
                                      });
                                    },
                                    title: Text(value),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: decoratedButton(() async {
                  String name = _nameController.text;
                  String price = _priceController.text;
                  String artist =
                      FirebaseAuth.instance.currentUser!.email.toString();
                  List<String> tags = selectedTags;
                  String description = _descriptionController.text;
                  createPost(
                      name, artist, description, _imagePath!, price, tags);
                  pushReplacementRoute(context, homescreenRoute);
                }, 'Post', 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateScreenAndroid extends StatefulWidget {
  const CreateScreenAndroid({super.key});

  @override
  State<CreateScreenAndroid> createState() => _CreateScreenAndroidState();
}

class _CreateScreenAndroidState extends State<CreateScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const Text(
              "Post Your Artwork",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                String url = await uploadPostToFirebaseAndroid(context);
                setState(() {
                  _imagePath = url;
                });
              },
              child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: _imagePath == null
                      ? Image.asset(
                          'assets/no_photo.jpg',
                          height: 300,
                          width: 300,
                        )
                      : Image.network(
                          _imagePath!,
                          height: 200,
                        )),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: _nameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Price',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: _priceController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Tags',
                    style: TextStyle(fontSize: 15),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: selectedTags.isNotEmpty
                              ? selectedTags.elementAt(0)
                              : '',
                          onChanged: (String? newValue) {
                            setState(() {
                              if (selectedTags.contains(newValue)) {
                                selectedTags.remove(newValue);
                              } else {
                                if (selectedTags.length < 5) {
                                  selectedTags.add(newValue!);
                                }
                              }
                            });
                          },
                          items: <String>[
                            '',
                            'Digital Art',
                            'Sketches',
                            'Anime',
                            'Contemporary',
                            'Cultural',
                            'Paintings',
                            'Abstract',
                            'Comics or Manga'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: 300,
                                child: CheckboxListTile(
                                  value: selectedTags.contains(value),
                                  activeColor: Colors.blue,
                                  onChanged: (bool? checked) {
                                    setState(() {
                                      if (selectedTags.contains(value)) {
                                        selectedTags.remove(value);
                                      } else {
                                        if (selectedTags.length < 5) {
                                          selectedTags.add(value);
                                        }
                                      }
                                    });
                                  },
                                  title: Text(value),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: decoratedButton(() async {
                String name = _nameController.text;
                String price = _priceController.text;
                String artist =
                    FirebaseAuth.instance.currentUser!.email.toString();
                List<String> tags = selectedTags;
                String description = _descriptionController.text;
                createPost(name, artist, description, _imagePath!, price, tags);
                pushReplacementRoute(context, homescreenRoute);
              }, 'Post', 200),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
