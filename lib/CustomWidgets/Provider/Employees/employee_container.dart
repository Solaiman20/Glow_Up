import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class EmployeeContainer extends StatelessWidget {
  final double? employeeRating;
  final String employeeName;
  void Function()? containerMethod;
  EmployeeContainer({
    super.key,
    required this.employeeName,
    required this.employeeRating,
    this.containerMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 16.w, right: 16.w, bottom: 16.h),
      child: GestureDetector(
        onTap: containerMethod,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(color: AppColors.white),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Text(employeeName, style: AppFonts.medium18),
              Spacer(),
              Row(
                children: [
                  employeeRating == null
                      ? Text(context.tr("No Rating"))
                      : Text("$employeeRating"),
                  Icon(Icons.star, color: Colors.yellow.shade600),
                ],
              ),

              // Replace it with add the method
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline, color: AppColors.goldenPeach),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
