import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderAboutScreen extends StatelessWidget {
  const ProviderAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "About GlowUp",
          style: AppFonts.semiBold24.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.background,
        elevation: 0.h, // remove shadow
        surfaceTintColor: Colors.transparent, // prevent Material3 overlay
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GlowUp — Your All-in-One Booking Partner",
              style: AppFonts.medium18,
            ),
            SizedBox(height: 16.h),
            Text(
              "GlowUp helps salons and beauty professionals reach more customers, manage appointments efficiently, and grow their business — all from one platform.",
              style: AppFonts.light16,
            ),
            SizedBox(height: 24.h),
            Text("Why Join GlowUp?", style: AppFonts.medium18),
            SizedBox(height: 12.h),
            _bullet("List your services for free"),
            _bullet("Get discovered by local clients"),
            _bullet("Receive and manage bookings in real-time"),
            _bullet("Flexible calendar and time slot management"),
            _bullet("Build trust through ratings & reviews"),
            SizedBox(height: 24.h),
            Text(
              "Questions? Contact us at support@glowup.com",
              style: AppFonts.light16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 20.sp)),
          Expanded(child: Text(text, style: AppFonts.light16)),
        ],
      ),
    );
  }
}
