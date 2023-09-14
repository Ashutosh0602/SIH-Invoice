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

  String getFileName(File file) {
    // Get the full file path
    String filePath = file.path;

    // Use the 'split' method to split the path into parts using the platform-specific separator
    List<String> pathParts = filePath.split(Platform.pathSeparator);

    // The last part of the path is the file name
    String fileName = pathParts.last;

    return fileName;
  }

  Future<TaskSnapshot> uploadFile(
      {required File file, required String uid}) async {
    // Generate a v1 (time-based) id
    String id = uuid.v1();

    final photoRef =
        storage.ref('pdf-invoice').child(uid).child(getFileName(file));

    final UploadTask uploadTask = photoRef.putFile(
      file,
      SettableMetadata(
        contentType: 'application/pdf', // Adjust content type if necessary
        customMetadata: <String, String>{'pdfId': id},
      ),
    );

    final TaskSnapshot taskSnap = await uploadTask;
    return taskSnap;
  }

  Future<void> deleteFile({required String uid, required String pdfId}) async {
    final photoRef = storage.ref('pdf-invoice').child(uid).child(pdfId);

    await photoRef.delete();
  }

  Future<List<Reference>> getAllPdfReferences(String uid) async {
    final ListResult result =
        await storage.ref('pdf-invoice').child(uid).listAll();

    return result.items;
  }
}
