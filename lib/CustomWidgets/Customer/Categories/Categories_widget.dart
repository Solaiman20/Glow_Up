import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class Categories extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String? svgIconPath;
  final VoidCallback onTap;

  const Categories({
    super.key,
    required this.isSelected,
    required this.label,
    this.svgIconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = AppColors.white;
    final Color unselectedColor = AppColors.softBrown;
    final Color selectedIconColor = AppColors.darkText;
    final Color unselectedIconColor = AppColors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 66.w,
            height: 66.h,
            decoration: BoxDecoration(
              color: isSelected ? selectedColor : unselectedColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: svgIconPath != null
                  ? SvgPicture.asset(
                      svgIconPath!,
                      width: 36.w,
                      height: 36.h,
                      colorFilter: ColorFilter.mode(
                        isSelected ? selectedIconColor : unselectedIconColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          SizedBox(height: 3.h), // spacing between circle and text
          Text(label, style: AppFonts.regular14),
        ],
      ),
    );
  }
}
