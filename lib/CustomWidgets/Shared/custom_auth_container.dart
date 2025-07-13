import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class BackgroundContainer extends StatelessWidget {
  final double heightSize;
  final Widget childWidget;
  const BackgroundContainer({
    super.key,
    required this.childWidget,
    required this.heightSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36.r),
            topRight: Radius.circular(36.r),
          ),
        ),
        height: (952 * heightSize).h,
        width: 402.w,
        child: childWidget,
      ),
    );
  }
}
