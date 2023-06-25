import 'package:art_wave/constants/upload_to_firebase.dart';
import 'package:art_wave/constants/is_android.dart';
import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../constants/user_data.dart';

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _websiteController = TextEditingController();
final TextEditingController _aboutController = TextEditingController();
final String _email = FirebaseAuth.instance.currentUser!.email.toString();

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
  String? url;
  void pushReplacementNamed(String routeName) {
    pushReplacementRoute(context, routeName);
  }

  void onPressed() async {
    String name = _usernameController.text;
    String bio = _aboutController.text;
    String site = _websiteController.text;
    await updateField(_email, 'username', name);
    await updateField(_email, 'about', bio);
    await updateField(_email, 'website', site);
    pushReplacementNamed(profileRoute);
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
          final String? imagePath = userData['imagePath'] as String?;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Text(
                    'Edit Public Profile',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      url = await uploadImageToFirebaseAndroid(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110),
                      child: ClipOval(
                        child: imagePath != null && imagePath.isNotEmpty
                            ? Image.network(
                                imagePath,
                                fit: BoxFit.fill,
                                height: 150,
                              )
                            : url != null
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    controller: _usernameController,
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
                    height: 15,
                  ),
                  const Text(
                    'Website',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    controller: _websiteController,
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
                    height: 15,
                  ),
                  const Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextField(
                    controller: _aboutController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  decoratedButton(onPressed, 'Save Changes', double.infinity)
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

class EditProfileWeb extends StatefulWidget {
  const EditProfileWeb({super.key});

  @override
  State<EditProfileWeb> createState() => _EditProfileWebState();
}

class _EditProfileWebState extends State<EditProfileWeb> {
  final user = FirebaseAuth.instance.currentUser;
  String? _url;

  void pushReplacementNamed(String routeName) {
    pushReplacementRoute(context, routeName);
  }

  void onPressed() async {
    String name = _usernameController.text;
    String bio = _aboutController.text;
    String site = _websiteController.text;
    await updateField(_email, 'username', name);
    await updateField(_email, 'about', bio);
    await updateField(_email, 'website', site);
    pushReplacementNamed(profileRoute);
  }

  @override
  void initState() {
    super.initState();
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
          final String? imagePath = userData['imagePath'] as String?;
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
                        onTap: () async {
                          _url = await uploadImageToFirebaseWeb(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 350),
                          child: ClipOval(
                            child: imagePath != null && imagePath.isNotEmpty
                                ? Image.network(
                                    imagePath,
                                    fit: BoxFit.fill,
                                    height: 150,
                                  )
                                : _url != null
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
                                          Radius.circular(5),
                                        ),
                                      ),
                                    ),
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
                                          Radius.circular(5),
                                        ),
                                      ),
                                    ),
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
                                          Radius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoratedButton(onPressed, 'Save Changes', 200)
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
