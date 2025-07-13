import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';

class FirstPageView extends StatelessWidget {
  GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  String? Function(String?) nameValidation;
  String? Function(String?) emailValidation;
  String? Function(String?) passwordValidation;
  String? Function(String?) confirmPasswordValidation;

  void Function() pressedMethod;

  FirstPageView({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.pressedMethod,
    required this.nameValidation,
    required this.emailValidation,
    required this.passwordValidation,
    required this.confirmPasswordValidation,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextfield(
                  textFieldcontroller: nameController,
                  textFieldHint: context.tr("Username"),
                  validationMethod: nameValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: emailController,
                  textFieldHint: context.tr("Email"),
                  validationMethod: emailValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: passwordController,
                  textFieldHint: context.tr("Password"),
                  isPassword: true,
                  validationMethod: passwordValidation,
                ),
                CustomTextfield(
                  textFieldcontroller: confirmPasswordController,
                  textFieldHint: context.tr("Confirm Password"),
                  isPassword: true,
                  validationMethod: confirmPasswordValidation,
                ),
              ],
            ),
          ),
          CustomElevatedButton(text: context.tr("Next"), onTap: pressedMethod),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
