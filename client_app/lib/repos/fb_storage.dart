import 'package:firebase_storage/firebase_storage.dart';

class FileStorage {
  FileStorage._();
  static final _storage = FirebaseStorage.instance;
  static Future<String> downloadPath(String imageName) async {
    String url = await _storage.ref('images/$imageName.jpg').getDownloadURL();
    return url;
  }
}