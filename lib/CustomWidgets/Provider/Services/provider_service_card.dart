import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Styles/app_colors.dart';

class ProviderServiceCard extends StatelessWidget {
  const ProviderServiceCard({super.key, required this.service, this.onDelete});
  final Services service;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      width: 398.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT: image with padding
          Padding(
            padding: EdgeInsets.all(8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: service.imageUrl,
                fit: BoxFit.cover,
                width: 140.w,
                height: double.infinity, // fill parent height
                placeholder: (ctx, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (ctx, url, err) =>
                    const Icon(Icons.error, color: AppColors.goldenPeach),
              ),
            ),
          ),
          // MIDDLE: text centered vertically
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // hug content
                children: [
                  Text(
                    service.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "SAR${service.price.toStringAsFixed(0)}",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // RIGHT: delete button, pinned top
          Padding(
            padding: EdgeInsets.all(4.h),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete_outlined, color: AppColors.goldenPeach),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
