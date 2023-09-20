import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'dart:io';

Future<void> sendReport(String title, String content) async{
  final CollectionReference reports = FirebaseFirestore.instance.collection('reports');
  DateTime currentTime = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedTime = formatter.format(currentTime);
  await reports.doc(title).set({
    'title': title,
    'content': content,
    'date': formattedTime,
    'sender': FirebaseAuth.instance.currentUser!.email.toString(),
  });
}


class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const ReportScreenWeb();
    } else {
      if (Platform.isAndroid) {
        return const ReportScreenAndroid();
      } else {
        return const Placeholder();
      }
    }
  }
}

class ReportScreenAndroid extends StatefulWidget {
  const ReportScreenAndroid({super.key});

  @override
  State<ReportScreenAndroid> createState() => _ReportScreenAndroidState();
}

class _ReportScreenAndroidState extends State<ReportScreenAndroid> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void pushHomeScreenRoute(){
      pushReplacementRoute(context, mainRoute);
    }

    return Scaffold(
      appBar: appbarWidget(context),
      drawer: drawerWidget(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Subject',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              maxLines: 1,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('What is your report about?'),
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
            const Text(
              'Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              maxLines: 20,
              controller: contentController,
              decoration: const InputDecoration(
                label: Text('Expand on the subject here'),
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
            Center(
              child: decoratedButton(() async {
                String title = titleController.text;
                String content = contentController.text;
                await sendReport(title, content);
                pushHomeScreenRoute();
              }, 'Submit', 200),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportScreenWeb extends StatefulWidget {
  const ReportScreenWeb({super.key});

  @override
  State<ReportScreenWeb> createState() => _ReportScreenWebState();
}

class _ReportScreenWebState extends State<ReportScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
