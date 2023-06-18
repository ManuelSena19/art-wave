import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_html/html.dart' as html;
import 'package:art_wave/constants/is_android.dart';
import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_web/firebase_storage_web.dart';
import 'package:firebase_core/firebase_core.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker_web/image_picker_web.dart';
import '../constants/user_data.dart';

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _websiteController = TextEditingController();
final TextEditingController _aboutController = TextEditingController();
final String _email = FirebaseAuth.instance.currentUser!.email.toString();

Future<void> updateField(String field, String newValue) async {
  DocumentReference<Map<String, dynamic>> userRef =
      FirebaseFirestore.instance.collection('users').doc(_email);
  await userRef.update({field: newValue});
}

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const EditProfileWeb();
    } else {
      if (isAndroid()) {
        return const EditProfileAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class EditProfileAndroid extends StatefulWidget {
  const EditProfileAndroid({super.key});

  @override
  State<EditProfileAndroid> createState() => _EditProfileAndroidState();
}

class _EditProfileAndroidState extends State<EditProfileAndroid> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class EditProfileWeb extends StatefulWidget {
  const EditProfileWeb({super.key});

  @override
  State<EditProfileWeb> createState() => _EditProfileWebState();
}

class _EditProfileWebState extends State<EditProfileWeb> {
  html.File? _imageFile;
  io.File? _file;
  final user = FirebaseAuth.instance.currentUser;
  String _url = '';

  void pushReplacementNamed(String routeName) {
    pushReplacementRoute(context, routeName);
  }

  Future<void> _pickImageWeb() async {
    final html.File image = (await ImagePickerWeb.getImageAsFile())!;
    final io.File ioImage = io.File(image.relativePath!);
    setState(() {
      _imageFile = image;
      _file = ioImage;
    });
  }

  @override
  void initState(){
    super.initState();
    FilePicker.platform = FilePickerWeb.platform;
  }

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
          final String? username = userData['username'] as String?;
          _usernameController.text = username!;
          final String? website = userData['website'] as String?;
          _websiteController.text = website!;
          final String? about = userData['about'] as String?;
          _aboutController.text = about!;
          return Scaffold(
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 75, horizontal: 300),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      const Text(
                        'Edit Public Profile',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _pickImageWeb,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 350),
                          child: ClipOval(
                            child: _imageFile != null
                                ? Image.asset(
                                    'assets/success.jpg',
                                    fit: BoxFit.fill,
                                    height: 150,
                                  )
                                : Image.asset(
                                    'assets/user.jpg',
                                    fit: BoxFit.fill,
                                    height: 150,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Click on the image above to change your profile picture',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 100, 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Username',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text(
                                    'Website',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: _usernameController,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    maxLines: 1,
                                    controller: _websiteController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    maxLines: 5,
                                    controller: _aboutController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await updateField('imagePath', _url);
                          String name = _usernameController.text;
                          String bio = _aboutController.text;
                          String site = _websiteController.text;
                          await updateField('username', name);
                          await updateField('about', bio);
                          await updateField('website', site);
                          pushReplacementNamed(profileRoute);
                        },
                        child: Container(
                          width: 200,
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
                              "Save Changes",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text('Check your network connection');
        }
      },
    );
  }
}
