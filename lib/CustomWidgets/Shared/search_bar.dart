import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final IconData leftIcon;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.leftIcon = Icons.search,
    this.hintText = "Search",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349.w,
      height: 49.h,

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(leftIcon, color: Theme.of(context).iconTheme.color),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
