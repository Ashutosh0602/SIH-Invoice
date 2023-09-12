import 'package:get/get.dart';
import 'package:invoice_app_sih/screens/add_company_details_page.dart';
import 'package:invoice_app_sih/screens/create_invoice_page.dart';
import 'package:invoice_app_sih/screens/home_page.dart';
import 'package:invoice_app_sih/screens/splash_screen.dart';

List<GetPage<dynamic>>? getAppPages() {
  return [
    GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: Routes.homeScreen, page: () => HomePage()),
    GetPage(name: Routes.addCompanyScreen, page: () => AddCompanyDetails()),
    GetPage(
        name: Routes.createInvoiceScreen, page: () => const CreateInvoice()),
  ];
}

class Routes {
  static String splashScreen = "/splashScreen";
  static String homeScreen = "/homePage";
  static String addCompanyScreen = "/addCompanyScreen";
  static String createInvoiceScreen = "/createInvoiceScreen";
}
