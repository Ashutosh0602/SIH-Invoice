import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UploadController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Uuid uuid = const Uuid();

  String bytesTransferred(TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  Future<TaskSnapshot> uploadFile(
      {required File file, required String uid}) async {
    // Generate a v1 (time-based) id
    String id = uuid.v1();

    final photoRef = storage.ref('photos').child(uid).child(id);

    final UploadTask uploadTask = photoRef.putFile(
      file,
      SettableMetadata(
        contentType: 'image/jpeg', // Adjust content type if necessary
        customMetadata: <String, String>{'photoId': id},
      ),
    );

    final TaskSnapshot taskSnap = await uploadTask;
    return taskSnap;
  }

  Future<void> deleteFile(
      {required String uid, required String photoId}) async {
    final photoRef = storage.ref('photos').child(uid).child(photoId);

    await photoRef.delete();
  }
}
