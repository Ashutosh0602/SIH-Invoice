import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/show_invoices_controller.dart';
import 'package:invoice_app_sih/styles/styles.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ShowInvoicesPage extends GetView<ShowInvoicesController> {
  const ShowInvoicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Invoices', style: appBarText()),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.pdfReferences.isEmpty) {
            return const Center(
              child: Text('No PDF invoices found.'),
            );
          } else {
            final pdfReferences = controller.pdfReferences;
            return ListView.builder(
              itemCount: pdfReferences.length,
              itemBuilder: (context, index) {
                final reference = pdfReferences[index];
                final pdfFileName = reference.name;

                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: Text(pdfFileName),
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        scrollable: true,
                        title: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'PDF Tools',
                            style: textStyle(),
                          ),
                        ),
                        content: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                Get.back();
                                controller.openPdfFile(reference);
                              },
                              label: const Text("Open Invoice PDF"),
                              icon: const Icon(Icons.file_open_outlined),
                              style: elevatedButtonStyle(),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Get.back();
                                await controller
                                    .deleteFileFromStorage(reference);
                              },
                              label: const Text("Delete Invoice PDF"),
                              icon: const Icon(Icons.file_open_outlined),
                              style: elevatedButtonStyle(),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Get.back();
                                Uint8List? bytes = await controller
                                    .downloadFileFromStorage(reference);
                                if (bytes != null) {
                                  await Printing.layoutPdf(
                                      onLayout: (format) async => bytes);
                                }
                              },
                              label: const Text("Print Invoice PDF"),
                              icon: const Icon(Icons.local_printshop_outlined),
                              style: elevatedButtonStyle(),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Get.back();
                                var file = await controller
                                    .downloadFileFromStorage(reference);
                                if (file != null) {
                                  // File opened successfully
                                  final tempFile = await controller
                                      .getTempFile(reference.name);
                                  await tempFile.writeAsBytes(file);
                                  Share.shareXFiles([XFile(tempFile.path)]);
                                }
                              },
                              label: const Text("Share Invoice PDF"),
                              icon: const Icon(Icons.share_rounded),
                              style: elevatedButtonStyle(),
                            ),
                            const SizedBox(height: 20),
                            TextButton.icon(
                                onPressed: () async {
                                  Get.back();
                                },
                                label: Text("back"),
                                icon: const Icon(Icons.home),
                                style: elevatedButtonStyle()),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
