import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/show_invoices_controller.dart';
import 'package:invoice_app_sih/styles/styles.dart';
import 'package:path_provider/path_provider.dart';
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
      body: FutureBuilder<List<Reference>>(
        future: controller.getAllPdfReferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No PDF invoices found.'),
            );
          } else {
            final pdfReferences = snapshot.data!;
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
                                controller.openPdfFile(reference);
                              },
                              label: const Text("Open Invoice PDF"),
                              icon: const Icon(Icons.file_open_outlined),
                              style: elevatedButtonStyle(),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () async {
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
                                Directory? dir =
                                    await getExternalStorageDirectory();

                                File file =
                                    File("${dir!.path}/${reference.name}.pdf");
                                final pdf = pw.Document();
                                var sharePdf =
                                    await file.writeAsBytes(await pdf.save());

                                Share.shareFiles([(sharePdf.path)]);
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
                              label: const Text("back"),
                              icon: const Icon(Icons.home),
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                                shape: const StadiumBorder(),
                                elevation: 0,
                              ),
                            ),
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
