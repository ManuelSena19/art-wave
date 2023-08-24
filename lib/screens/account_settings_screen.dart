import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/user_data.dart';
import 'package:art_wave/screens/loading_screen.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const AccountSettingsWeb();
    } else {
      if (Platform.isAndroid) {
        return const AccountSettingsAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class AccountSettingsAndroid extends StatefulWidget {
  const AccountSettingsAndroid({super.key});

  @override
  State<AccountSettingsAndroid> createState() => _AccountSettingsAndroidState();
}

class _AccountSettingsAndroidState extends State<AccountSettingsAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const Text(
              "See information about your account, change your password or learn about your deactivation options",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Colors.orange,
              ),
              title: const Text(
                "Account Information",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "See account information like your username and email address.",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                pushRoute(context, accountInfoRoute);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.lock_outlined,
                color: Colors.orange,
              ),
              title: const Text(
                "Change Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Change your password or reset it at anytime.",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                pushRoute(context, resetPasswordRoute);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.cancel_outlined,
                color: Colors.orange,
              ),
              title: const Text(
                "Deactivate Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Check out how you can deactivate your Campus Connect account.",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class AccountSettingsWeb extends StatefulWidget {
  const AccountSettingsWeb({super.key});

  @override
  State<AccountSettingsWeb> createState() => _AccountSettingsWebState();
}

class _AccountSettingsWebState extends State<AccountSettingsWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final String _email = FirebaseAuth.instance.currentUser!.email.toString();
  late final DocumentSnapshot snapshot;

  Future<String> getUsername(String email) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    if (snapshot.exists) {
      final data = snapshot.data()!;
      final username = data['username'];
      return username;
    }
    throw "User not found";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: getUserData(_email),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  final userData = snapshot.data!;
                  final String name = userData['username'] as String? ?? 'name';
                  return ListTile(
                    title: const Text(
                      "Username",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      name,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return const LoadingScreen();
                }
              },
            ),
            ListTile(
              title: const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _email,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              title: const Text(
                "Sign Out",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                "Sign out of your account",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
