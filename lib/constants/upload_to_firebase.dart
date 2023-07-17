import 'package:art_wave/constants/push_routes.dart';
import 'package:art_wave/constants/routes.dart';
import 'package:art_wave/constants/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

ImagePicker _picker = ImagePicker();
final String _email = FirebaseAuth.instance.currentUser!.email.toString();

Future<String> uploadImageToFirebaseWeb(BuildContext context) async {
  XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  final fileBytes = await pickedFile!.readAsBytes();
  var now = DateTime.now().millisecondsSinceEpoch;
  Reference reference = FirebaseStorage.instance.ref().child("profiles/$now");

  final UploadTask uploadTask = reference.putData(fileBytes);

  final String url = await (await uploadTask).ref.getDownloadURL();

  updateField(_email, 'imagePath', url);

  pushReplacementRoute(context, editProfileRoute);

  return url;
}

Future<String> uploadPostToFirebaseWeb(BuildContext context) async {
  XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  final fileBytes = await pickedFile!.readAsBytes();
  var now = DateTime.now().millisecondsSinceEpoch;
  Reference reference = FirebaseStorage.instance.ref().child("posts/$now");

  final UploadTask uploadTask = reference.putData(fileBytes);

  final String url = await (await uploadTask).ref.getDownloadURL();

  pushReplacementRoute(context, createRoute);

  return url;
}

Future<String> uploadImageToFirebaseAndroid(BuildContext context) async {
  XFile image = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
  File? imageFile = File(image.path);

  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  final Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');
  final UploadTask uploadTask = storageReference.putFile(imageFile);
  final String downloadURL = await (await uploadTask).ref.getDownloadURL();
  String url = downloadURL;

  updateField(_email, 'imagePath', url);

  pushReplacementRoute(context, editProfileRoute);

  return url;
}

Future<String> uploadPostToFirebaseAndroid(BuildContext context) async {
  XFile image = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
  File? imageFile = File(image.path);

  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  final Reference storageReference =
  FirebaseStorage.instance.ref().child('posts/$fileName');
  final UploadTask uploadTask = storageReference.putFile(imageFile);
  final String downloadURL = await (await uploadTask).ref.getDownloadURL();
  String url = downloadURL;

  pushReplacementRoute(context, createRoute);

  return url;
}
