import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Styles/app_font.dart';

class ThirdPageView extends StatelessWidget {
  const ThirdPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          spacing: 15.h,
          children: [
            Center(
              child: Text(
                context.tr(
                  "Your account have been created Please check your email to confirm it",
                ),
                style: AppFonts.medium18,
              ),
            ),

            CustomElevatedButton(
              text: context.tr("Go to Login"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
