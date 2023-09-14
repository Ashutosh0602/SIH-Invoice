import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/auth_controller.dart';
import 'package:invoice_app_sih/controllers/theme_controller.dart';
import 'package:invoice_app_sih/controllers/upload_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ShowInvoicesController extends GetxController {
  // service
  final UploadController _uploadController = Get.find();
  final AuthController _authController = Get.find();
  final ThemeController _themeController = Get.find();

  RxBool get isDarkTheme => _themeController.isDarkTheme;
  //pdf-invoices
  final isLoading = false.obs;
  RxList<Reference> pdfReferences = <Reference>[].obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchPdfReferences();
  }

  // Fetch PDF references and populate pdfReferences
  Future<void> fetchPdfReferences() async {
    try {
      isLoading.value = true; // Set isLoading to true when fetching
      final references = await _uploadController
          .getAllPdfReferences(_authController.getUser.uid);
      pdfReferences.assignAll(references);
    } catch (e) {
      print('Error fetching PDF references: $e');
    } finally {
      isLoading.value = false; // Set isLoading to false when done fetching
    }
  }

  Future<File> getTempFile(String fileName) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName.pdf';
    return File(filePath);
  }

  Future<Uint8List?> downloadFileFromStorage(Reference reference) async {
    EasyLoading.show(status: 'downloading...');
    final storage = FirebaseStorage.instance;
    final file = await storage.ref(reference.fullPath).getData();
    EasyLoading.dismiss();
    return file;
  }

  Future<void> deleteFileFromStorage(Reference reference) async {
    try {
      EasyLoading.show(status: "Deleteing file...");
      final storage = FirebaseStorage.instance;
      await storage.ref(reference.fullPath).delete();
      EasyLoading.dismiss();
      Get.snackbar("Delete file from Cloud", "Successful",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white);
      // pdfReferences.remove(reference);
      fetchPdfReferences();
      // update();
    } catch (e) {
      Get.snackbar("Delete file from Cloud", "Error",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  Future<void> openPdfFile(Reference reference) async {
    var file = await downloadFileFromStorage(reference);
    if (file != null) {
      // File opened successfully
      final tempFilePath = await getTempFile(reference.name);
      await tempFilePath.writeAsBytes(file);
      await OpenFile.open(tempFilePath.path);
    } else {
      // Handle errors here
      Get.snackbar(
          "Error opening the PDF file.", "Not able to download file from cloud",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 7),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }
}
