import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app_sih/controllers/auth_controller.dart';
import 'package:invoice_app_sih/screens/widgets/custom_button.dart';
import 'package:invoice_app_sih/screens/widgets/custom_text_field.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();
    return Scaffold(
      key: controller.forgotPasswordEmailScaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 0.0,
        title: Text('Sign up', style: Theme.of(context).textTheme.displayLarge),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 15),
            child: Form(
              key: controller.forgotPasswordEmailFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Reset your password"),
                      Obx(() {
                        return CustomTextfieldWidget(
                          labelText: 'Email',
                          controller: controller.forgotPassEmailController,
                          onChanged: controller.forgotPassEmailChanged,
                          onSubmitted: (value) =>
                              controller.forgotPassEmailController.text = value,
                          hintText: 'Enter your registered email',
                          keyboardType: TextInputType.emailAddress,
                          //prefixIcon: Icons.account_balance_rounded,
                          errorText: controller.forgotPassEmailErrorText.value,
                          validator: (value) =>
                              controller.validateforgotPassEmail(value!),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButtonWidget(
                          buttonName: 'Reset Password',
                          onPressed: controller.resetPassword),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
