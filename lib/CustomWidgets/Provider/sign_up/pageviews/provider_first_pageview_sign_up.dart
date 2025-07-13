import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';

class ProviderFirstPageviewSignUp extends StatelessWidget {
  GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  String? Function(String?) nameValidation;
  String? Function(String?) phoneValidation;
  String? Function(String?) emailValidation;
  String? Function(String?) passwordValidation;
  String? Function(String?) confirmPasswordValidation;

  void Function() pressedMethod;

  ProviderFirstPageviewSignUp({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.pressedMethod,
    required this.nameValidation,
    required this.phoneValidation,
    required this.emailValidation,
    required this.passwordValidation,
    required this.confirmPasswordValidation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextfield(
                  textFieldcontroller: nameController,
                  textFieldHint: "Username".tr(),
                  validationMethod: nameValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: phoneController,
                  textFieldHint: "Phone".tr(),
                  validationMethod: phoneValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: emailController,
                  textFieldHint: "Email".tr(),
                  validationMethod: emailValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: passwordController,
                  textFieldHint: "Password".tr(),
                  isPassword: true,
                  validationMethod: passwordValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: confirmPasswordController,
                  textFieldHint: "Confirm Password".tr(),
                  isPassword: true,
                  validationMethod: confirmPasswordValidation,
                ),
              ],
            ),
          ),
          CustomElevatedButton(text: "Next".tr(), onTap: pressedMethod),
        ],
      ),
    );
  }
}
