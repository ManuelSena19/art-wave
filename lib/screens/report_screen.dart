import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/utilities/appbar_widget.dart';
import 'package:art_wave/utilities/decorated_button.dart';
import 'package:art_wave/utilities/drawer_widget.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import '../utilities/show_error_dialog.dart';


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
      pushReplacementRoute(context, homescreenRoute);
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
                String subject = titleController.text;
                String body = contentController.text;
                try{
                  final Email email = Email(
                    body: body,
                    subject: subject,
                    recipients: ['emmanueldokeii@gmail.com'],
                    isHTML: false,
                  );
                  await FlutterEmailSender.send(email);
                  pushHomeScreenRoute();
                } catch (e){
                  await showErrorDialog(context, e.toString());
                }
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
