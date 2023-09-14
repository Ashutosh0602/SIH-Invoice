import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/show_invoices_controller.dart';
import 'package:invoice_app_sih/styles/styles.dart';

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
                    controller.openPdfFile(reference);
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
