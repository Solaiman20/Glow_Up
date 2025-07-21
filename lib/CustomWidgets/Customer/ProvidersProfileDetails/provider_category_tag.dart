import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderCategoryTag extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  const ProviderCategoryTag({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = AppColors.white;
    final Color unselectedColor = AppColors.softBrown;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppFonts.light16.copyWith(
            color: isSelected ? AppColors.backgroundDark : AppColors.white,
          ),
        ),
      ),
    );
  }
}
