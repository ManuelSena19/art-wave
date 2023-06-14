import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const EditProfileWeb();
    } else {
      if (Platform.isAndroid) {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [],
      ),
    );
  }
}
