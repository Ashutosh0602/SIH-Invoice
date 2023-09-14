import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_app_sih/controllers/auth_controller.dart';
import 'package:invoice_app_sih/controllers/theme_controller.dart';
import 'package:invoice_app_sih/controllers/upload_controller.dart';
import 'package:invoice_app_sih/models/models.dart';
import 'package:invoice_app_sih/routes/route_const.dart';
import 'package:pdf/pdf.dart';

HomeController controller = Get.put(HomeController());

class HomeController extends GetxController {
  //services
  final AuthController _authController = Get.find();
  final UploadController _uploadController = Get.find();
  final ThemeController _themeController = Get.find();
  var pagesViewScaffoldKey = GlobalKey<ScaffoldState>();

  RxBool get isDarkTheme => _themeController.isDarkTheme;

  void openDrawer() {
    pagesViewScaffoldKey.currentState?.openDrawer();
    update();
  }

  // Product
  List<Products> productsList = <Products>[].obs;

  // Customer
  List<Customer> customersList = <Customer>[].obs;

  // Page/tab Index For NavigationBar
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // Color Theme
  var themeColor = Colors.blue.obs;

  // Create Invoice
  RxDouble total = 0.0.obs;
  var counter = [].obs;
  var totalList = <double>[].obs;

  // Create  PDF
  var pdfColor = PdfColors.blue.obs;
  var pdfColorLight = PdfColors.blue200.obs;

  var companyName = "".obs;
  var companyAddress = "".obs;
  var companyAddress2 = "".obs;
  var companyAddress3 = "".obs;
  var companyGSTNo = "".obs;
  var companyNumber = "".obs;
  var companyEmail = "".obs;

  var initialTaxValue = 0.obs;

  var selectedImagePath = "".obs;

  void getImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      selectedImagePath.value = pickedImage.path;
    }
  }

  //auth functionality
  void logout() {
    _authController.signOut();
  }

  //service functionality
  Future<void> uploadFileToCloud(File file) async {
    EasyLoading.show(status: 'uploading...');
    await _uploadController.uploadFile(
        file: file, uid: _authController.getUser.uid);
    EasyLoading.dismiss();
  }

  void openInvoiceScreen() {
    Get.toNamed(Routes.showInvoiceScreen);
  }
}
