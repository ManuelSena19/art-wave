import 'package:art_wave/constants/push_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:art_wave/constants/routes.dart';

Widget drawerWidget(BuildContext context) {
  return Drawer(
    elevation: 0,
    child: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Art Wave',
          style: GoogleFonts.vibur(
              textStyle: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        const Divider(
          thickness: 3,
          color: Colors.orangeAccent,
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, homescreenRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, profileRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.message_outlined),
          title: const Text(
            'Messages',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, messagesRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.explore_outlined),
          title: const Text(
            'Explore',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, exploreRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.create_new_folder_outlined),
          title: const Text(
            'Create',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, createRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, settingsRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.report_outlined),
          title: const Text(
            'Report a Problem',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            pushRoute(context, reportRoute);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text(
            'Sign Out',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconColor: Colors.orange,
          onTap: () {
            FirebaseAuth.instance.signOut();
            pushReplacementRoute(context, loginRoute);
          },
        ),
        const Divider(
          thickness: 3,
          color: Colors.orangeAccent,
        ),
      ],
    ),
  );
}
