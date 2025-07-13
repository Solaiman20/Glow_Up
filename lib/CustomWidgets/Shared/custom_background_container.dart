import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class CustomBackgroundContainer extends StatelessWidget {
  // to choose either Padding1 or Padding2
  bool paddingSize;

  double height;
  Widget childWidget;
  CustomBackgroundContainer({
    super.key,
    required this.childWidget,
    required this.height,
    this.paddingSize = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSize
          ? EdgeInsets.symmetric(horizontal: 16.w)
          : EdgeInsetsGeometry.symmetric(horizontal: 36.w),
      child: Container(
        width: 402.w,
        height: height.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: childWidget,
      ),
    );
  }
}
