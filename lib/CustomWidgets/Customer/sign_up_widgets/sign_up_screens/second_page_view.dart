import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/CustomMaps/custom_maps.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';

class SecondPageView extends StatelessWidget {
  GlobalKey<FormState> formKey;
  final TextEditingController controller;

  String? Function(String?) addressValidation;
  void Function() pressedMethod;

  SecondPageView({
    super.key,
    required this.controller,
    required this.addressValidation,
    required this.pressedMethod,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15.h,
        children: [
          // Relpace the placeholder with googleMap instance

          // The size of the instance
          CustomMaps(),
          Form(
            key: formKey,
            child: CustomTextfield(
              textFieldHint: context.tr("Public Address"),
              textFieldcontroller: controller,
              validationMethod: addressValidation,
            ),
          ),
          CustomElevatedButton(
            text: context.tr("Sign Up"),
            onTap: pressedMethod,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
