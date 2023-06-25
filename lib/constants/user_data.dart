import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getUserData(String email) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(email);
  final userSnapshot = await userRef.get();
  if (userSnapshot.exists) {
    return userSnapshot.data() as Map<String, dynamic>;
  }
  return {};
}

Future<void> updateField(String email, String field, String newValue) async {
  DocumentReference<Map<String, dynamic>> userRef =
  FirebaseFirestore.instance.collection('users').doc(email);
  await userRef.update({field: newValue});
}