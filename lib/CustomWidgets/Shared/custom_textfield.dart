import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  bool isPassword;
  bool numbersOnly;
  final TextEditingController textFieldcontroller;
  final String textFieldHint;
  final String? Function(String?) validationMethod;
  final String? initialText;

  CustomTextfield({
    super.key,
    required this.textFieldHint,
    required this.textFieldcontroller,
    this.isPassword = false,
    this.numbersOnly = false,
    required this.validationMethod,
    this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: TextFormField(
        keyboardType: numbersOnly ? TextInputType.number : null,
        inputFormatters: numbersOnly
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        controller: textFieldcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightTextDark,
          hintText: textFieldHint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
        ),
        obscureText: isPassword,
        obscuringCharacter: "*",
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        validator: validationMethod,
      ),
    );
  }
}
