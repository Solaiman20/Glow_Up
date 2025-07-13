import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Screens/Customer/BookingDetails/booking_details_screen.dart';
import 'package:glowup/Styles/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final Services service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookingDetailsScreen(service: service),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: Theme.of(context).cardColor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image & Overlays
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: service.imageUrl,
                    height: 160.h,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),

                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.goldenPeach,
                      size: 75.h,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      service.provider!.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),

            /// Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          softWrap: false,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'SAR ${service.price.toStringAsFixed(0)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          service.provider!.address ?? "",
                          softWrap: true,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    service.provider!.distanceFromUser!,
                    softWrap: true,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
