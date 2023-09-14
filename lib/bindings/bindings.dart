import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/auth_controller.dart';
import 'package:invoice_app_sih/controllers/home_controller.dart';
import 'package:invoice_app_sih/controllers/login_controller.dart';
import 'package:invoice_app_sih/controllers/show_invoices_controller.dart';
import 'package:invoice_app_sih/controllers/signup_controller.dart';
import 'package:invoice_app_sih/controllers/theme_controller.dart';
import 'package:invoice_app_sih/controllers/upload_controller.dart';

//controllers
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginFormController>(() => LoginFormController());
  }
}

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpFormController>(() => SignUpFormController());
  }
}

class ShowInvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowInvoicesController>(() => ShowInvoicesController());
  }
}

//services
class ServiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UploadController>(UploadController(), permanent: true);
  }
}
