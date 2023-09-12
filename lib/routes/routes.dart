import 'package:get/get.dart';
import 'package:invoice_app_sih/bindings/bindings.dart';
import 'package:invoice_app_sih/routes/route_const.dart';
import 'package:invoice_app_sih/screens/add_company_details_page.dart';
import 'package:invoice_app_sih/screens/create_invoice_page.dart';
import 'package:invoice_app_sih/screens/forget_screem.dart';
import 'package:invoice_app_sih/screens/home_page.dart';
import 'package:invoice_app_sih/screens/login_screen.dart';
import 'package:invoice_app_sih/screens/register_screen.dart';
import 'package:invoice_app_sih/screens/splash_screen.dart';

List<GetPage<dynamic>>? getAppPages() {
  return [
    GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: Routes.homeScreen, page: () => HomePage()),
    GetPage(name: Routes.addCompanyScreen, page: () => AddCompanyDetails()),
    GetPage(
        name: Routes.createInvoiceScreen, page: () => const CreateInvoice()),
    GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.signupScreen,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(name: Routes.forgetScreen, page: () => const ForgotScreen()),
  ];
}
