import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/auth_controller.dart';
import 'package:invoice_app_sih/controllers/login_controller.dart';
import 'package:invoice_app_sih/controllers/signup_controller.dart';

//controllers
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<LoginFormController>(() => LoginFormController());
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpFormController>(() => SignUpFormController());
  }
}

//services
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
