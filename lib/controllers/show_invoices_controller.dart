import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  final isLoading = true.obs;
  final pdfReferences = <Reference>[].obs;

  Future<List<Reference>> getAllPdfReferences() {
    return _uploadController.getAllPdfReferences(_authController.getUser.uid);
  }

  Future<File> getTempFile(String fileName) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName.pdf';
    return File(filePath);
  }

  Future<void> openPdfFile(Reference reference) async {
    final storage = FirebaseStorage.instance;
    final file = await storage.ref(reference.fullPath).getData();

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
