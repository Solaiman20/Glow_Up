import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderTag extends StatelessWidget {
  const ProviderTag({super.key, required this.theProvider});
  final Provider theProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,

      width: 264.w,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.r),
              child: CachedNetworkImage(
                imageUrl: theProvider.avatarUrl ?? "",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColors.goldenPeach),
                height: 35.h,
                width: 35.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(theProvider.name, style: AppFonts.bold20),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
