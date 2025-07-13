import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart'; // Make sure this has AppColors.darkText

class StatusToggle extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const StatusToggle({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<String> options = [
    'Pending',
    'Status',
    'Paid',
    'Completed',
  ];
  static const Color softBrown = Color(0xFFB8A493);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Full background is white
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? softBrown : Colors.transparent,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  options[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
