import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker _picker = ImagePicker();

Future<String> uploadImageToFirebaseWeb() async {
  XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  final fileBytes = await pickedFile!.readAsBytes();
  var now = DateTime.now().millisecondsSinceEpoch;
  Reference reference = FirebaseStorage.instance.ref().child("profiles/$now");

  final UploadTask uploadTask = reference.putData(fileBytes);

  final String url = await (await uploadTask).ref.getDownloadURL();

  print(url);

  return url;
}
