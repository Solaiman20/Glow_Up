import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/button.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data (from Appointment model)
    final String serviceName = "Haircut & Blow-Dry";
    final String providerName = "Lana Rose Salon";
    final String appointmentDate = "Tuesday, July 2, 2025";
    final String appointmentTime = "4:00 PM";
    final String location = "Al Maqa, Riyadh";
    final String price = "SAR 207 (incl. VAT)";

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/correct.png"),
              ],
            ),
            SizedBox(height: 40.h),
            Text("Booking sent for this time.", style: AppFonts.semiBold24),
            SizedBox(height: 16.h),
            Text("Confirmation email on the way.", style: AppFonts.light16),
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Booking Details:", style: AppFonts.regular14),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Service", serviceName),
                  _divider(),
                  _infoRow("Provider", providerName),
                  _divider(),
                  _infoRow("Date", appointmentDate),
                  _divider(),
                  _infoRow("Time", appointmentTime),
                  _divider(),
                  _infoRow("Location", location),
                  _divider(),
                  _infoRow("Price", price),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              text: "Confirm",
              onTap: () {
                Navigator.pushNamed(context, '/navbar');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        
        children: [
        
      
          Text(value, style: AppFonts.light16),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1.h,
      width: 20.w,
      color: AppColors.darkText.withOpacity(0.08),
      margin: EdgeInsets.symmetric(vertical: 6.h),
    );
  }
}

