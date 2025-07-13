import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Need Help?".tr(), style: AppFonts.semiBold24),
              SizedBox(height: 16.h),
              Text(
                "For support, contact us at:".tr(),
                style: AppFonts.light16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              SelectableText(
                "support@glowup.com",
                style: AppFonts.medium18.copyWith(color: AppColors.darkText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
