import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:invoice_app_sih/routes/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      darkTheme: ThemeData(
          brightness: Brightness.dark, appBarTheme: const AppBarTheme()),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      getPages: getAppPages(),
    ),
  );
}
