import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Providers/provider_tag.dart';
import 'package:glowup/CustomWidgets/Customer/Services/service_card.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key, required this.provider});
  final Provider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32.w),
          child: ProviderTag(theProvider: provider),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(left: 32.w),
          child: SizedBox(
            height: 310.h,
            width: context.getScreenWidth(size: 1.w),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.services.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 310.h,
                  width: 230.w,
                  child: ServiceCard(service: provider.services[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
