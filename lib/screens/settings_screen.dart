import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:io';

import '../constants/push_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SettingsScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const SettingsScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}


class SettingsScreenAndroid extends StatefulWidget {
  const SettingsScreenAndroid({super.key});

  @override
  State<SettingsScreenAndroid> createState() => _SettingsScreenAndroidState();
}

class _SettingsScreenAndroidState extends State<SettingsScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: Colors.orange,
            ),
            title: const Text(
              "Your Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "Manage and see information about your account.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){
              pushRoute(context, accountSettingsRoute);
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
            title: const Text("Security and Account Access",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Manage your account's security and track usage.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.security_outlined,
              color: Colors.orange,
            ),
            title: const Text("Privacy and Security",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Manage all the information you see and share to others on Art Wave.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.orange,
            ),
            title: const Text("Notifications",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Select the notifications you receive about your interests and activities.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.accessibility_outlined,
              color: Colors.orange,
            ),
            title: const Text("Accessibility and Display",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Change accessibility settings and how Art Wave content is displayed to you.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.orange,
            ),
            title: const Text("Additional Resources",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Check out other resources and how they can be helpful to you.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.monetization_on_outlined,
              color: Colors.orange,
            ),
            title: const Text("Monetization",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
              "Manage monetization options and see how you can make more money.",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}


class SettingsScreenWeb extends StatefulWidget {
  const SettingsScreenWeb({super.key});

  @override
  State<SettingsScreenWeb> createState() => _SettingsScreenWebState();
}

class _SettingsScreenWebState extends State<SettingsScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

