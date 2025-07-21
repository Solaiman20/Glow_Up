import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/Categories_widget.dart';
import 'package:glowup/CustomWidgets/Customer/ProvidersProfileDetails/provider_category_tag.dart';
import 'package:glowup/CustomWidgets/Customer/Services/service_card.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Screens/Customer/ProvidersProfileDetails/bloc/providers_profile_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProvidersProfileDetailsScreen extends StatelessWidget {
  const ProvidersProfileDetailsScreen({super.key, required this.provider});
  final Provider provider;

  @override
  Widget build(BuildContext context) {
    final mainIcons = [
      'assets/svgs/hair_comb 1.svg',
      'assets/svgs/Make_up.svg',
      'assets/svgs/Nail_polish.svg',
      'assets/svgs/Make_up.svg',
      'assets/svgs/Make_up.svg',
    ];
    return BlocProvider(
      create: (context) => ProvidersProfileDetailsBloc(),
      child:
          BlocBuilder<
            ProvidersProfileDetailsBloc,
            ProvidersProfileDetailsState
          >(
            builder: (context, state) {
              final bloc = context.read<ProvidersProfileDetailsBloc>();
              final categories = bloc.categories;
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark,
                            ),
                            width: context.getScreenWidth(size: 1),
                            height: 150.h,
                            child: CachedNetworkImage(
                              imageUrl: "${provider.bannerUrl}",
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.calendarDay,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image, color: AppColors.white),
                              height: 150.h,
                              width: context.getScreenWidth(size: 1),
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Need to be tested
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: -54.h,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: provider.avatarUrl!,
                                  height: 120.h,
                                  width: 120.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.softBrown,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      "assets/images/profile.png",
                                      height: 120.h,
                                      width: 120.h,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              provider.avgRating?.toStringAsFixed(1) ??
                                  "No Rating",
                            ),
                            Icon(Icons.star, color: Colors.yellow),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.h),
                      Container(
                        height: 152.h,
                        width: 370.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          provider.bio,
                          style: AppFonts.regular14.copyWith(
                            wordSpacing: 3.w,
                            height: 2.h,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: SizedBox(
                          width: context.getScreenWidth(size: 1),
                          height: 40.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: ProviderCategoryTag(
                                  label: context.tr(categories[index]),
                                  isSelected: bloc.selectedIndex == index,
                                  onTap: () {
                                    bloc.selectedCategory = categories[index];
                                    bloc.add(CategorySelectEvent(index));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// 🔸 SERVICES LIST
                      SizedBox(
                        height: 400.h,
                        width: context.getScreenWidth(size: 1.w),

                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          itemCount: provider.services.where((service) {
                            return service.category == bloc.selectedCategory;
                          }).length,
                          itemBuilder: (context, index) {
                            final filteredServices = provider.services.where((
                              service,
                            ) {
                              return service.category == bloc.selectedCategory;
                            }).toList();
                            final service = filteredServices[index];
                            return SizedBox(
                              width: 230.w,
                              height: 300.h,
                              child: ServiceCard(service: service),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
