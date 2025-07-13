import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDescription extends StatelessWidget {
  const ServiceDescription({super.key, required this.service});
  final Services service;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: service.imageUrl,
          height: 282.h,
          width: 401.w,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          fit: BoxFit.cover,
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppFonts.semiBold24),
                  SizedBox(height: 4.h),
                  Text(service.provider!.name, style: AppFonts.italic16),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        service.provider?.avgRating?.toStringAsFixed(1) ??
                            "No Rating",
                      ),
                      Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text("SAR ${service.price.toStringAsFixed(0)}"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 152.h,
          width: 370.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            service.description,
            style: AppFonts.regular14.copyWith(wordSpacing: 3.w, height: 2.h),
            textAlign: TextAlign.start,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          alignment: Alignment.center,
          height: 192.h,
          width: 370.w,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  service.atHome ? "Location" : "Press to go to the location",
                  style: AppFonts.regular14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 8.h),

              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                height: 120.h,
                width: 323.w,
                child: service.atHome
                    ? Column(
                        children: [
                          Text(
                            "At Home Service",
                            style: AppFonts.black26.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "This service is available at your location. Contact the provider for more details.",
                            style: AppFonts.regular14,
                            textAlign: TextAlign.center,
                          ),
                          if (!service.atHome) ...[
                            SizedBox(height: 8.h),
                            Text(
                              service.provider!.phone!,
                              style: AppFonts.regular22,
                            ),
                          ],
                        ],
                      )
                    : GoogleMap(
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        onTap: (argument) async {
                          if (!await launchUrl(
                            Uri.parse(service.provider!.mapsUrl!),
                          )) {
                            log(
                              'Could not launch ${service.provider!.mapsUrl!}',
                            );
                            throw Exception(
                              'Could not launch ${service.provider!.mapsUrl!}',
                            );
                          }
                        },

                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            service.provider?.latitude ?? 0,
                            service.provider?.longitude ?? 0,
                          ),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(service.provider!.name),
                            position: LatLng(
                              service.provider?.latitude ?? 0,
                              service.provider?.longitude ?? 0,
                            ),
                          ),
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
