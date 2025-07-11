import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  // Singleton
  static final FirebaseService instance = FirebaseService._internal();
  FirebaseService._internal();

  Future<String?> uploadImages(File? image) async {
    if (image == null) return null;

    try {
      const uuid = Uuid();
      final storageRef =
          FirebaseStorage.instance.ref().child("images/${uuid.v4()}");
      await storageRef.putFile(File(image.path));
      String urli = await storageRef.getDownloadURL();
      return urli;
    } catch (e) {
      return null;
    }
  }
}
