import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/login_controller.dart';
import 'package:invoice_app_sih/routes/route_const.dart';
import 'package:invoice_app_sih/routes/routes.dart';
import 'package:invoice_app_sih/screens/widgets/custom_button.dart';
import 'package:invoice_app_sih/screens/widgets/custom_password_field.dart';
import 'package:invoice_app_sih/screens/widgets/custom_text_field.dart';

class LoginScreen extends GetView<LoginFormController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.loginScaffoldKey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 220,
                        height: 220,
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return CustomTextfieldWidget(
                              labelText: 'Email',
                              controller: controller.emailController,
                              onChanged: controller.emailChanged,
                              onSubmitted: (value) =>
                                  controller.emailController.text = value,
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              //prefixIcon: Icons.email,
                              errorText: controller.emailErrorText.value,
                              validator: (value) =>
                                  controller.validateEmail(value!),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return CustomPasswordfieldWidget(
                              onTap: () {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              },
                              labelText: 'Password',
                              controller: controller.passwordController,
                              onChanged: controller.passwordChanged,
                              onSubmitted: (value) =>
                                  controller.passwordController.text = value,
                              hintText: 'Enter your passowrd',
                              keyboardType: TextInputType.name,
                              fontIcon: Icons.remove_red_eye,
                              //prefixIcon: Icons.security,
                              errorText: controller.passwordErrorText.value,
                              obscureText: controller.showPassword.value,
                              validator: (value) =>
                                  controller.validatePassword(value!),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.forgetScreen),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          CustomButtonWidget(
                            buttonName: 'Login',
                            onPressed: controller.checkFormValidation,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.signupScreen),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text("Don't have an account? ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.signupScreen),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text("Sign Up",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
