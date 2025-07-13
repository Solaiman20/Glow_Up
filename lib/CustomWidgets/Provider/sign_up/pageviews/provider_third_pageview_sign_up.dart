import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderThirdPageviewSignUp extends StatelessWidget {
  const ProviderThirdPageviewSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        spacing: 15.h,
        children: [
          Center(
            child: Text(
              "Your account have been created Please check your email to confirm it"
                  .tr(),
              style: AppFonts.medium18,
            ),
          ),

          CustomElevatedButton(
            text: "Go to Login".tr(),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
