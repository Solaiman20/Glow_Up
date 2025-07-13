import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Categories/categories_widget.dart';
import 'package:glowup/CustomWidgets/Customer/Services/service_card.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';
import 'package:glowup/Screens/Customer/Services/bloc/home_bloc.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(UpdateUIEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();
          final categories = bloc.categories;

          final mainIcons = [
            'assets/svgs/hair_comb 1.svg',
            'assets/svgs/Make_up.svg',
            'assets/svgs/Nail_polish.svg',
            'assets/svgs/Make_up.svg',
            'assets/svgs/Make_up.svg',
          ];
          return Scaffold(
            body: SizedBox(
              height: context.getScreenHeight(size: 1.h),
              width: context.getScreenWidth(size: 1.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Text.rich(
                        TextSpan(
                          text: context.tr("Hello,"),
                          style: AppFonts.black32,
                          children: [
                            TextSpan(
                              text:
                                  " ${bloc.supabaseConnect.userProfile?.username ?? ""}",
                              style: AppFonts.black32,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.w, top: 10.h),
                      child: Text(
                        context.tr("Are you ready for a Glow Up"),
                        style: AppFonts.light16,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      children: [
                        SizedBox(width: 32.w),
                        CustomSearchBar(
                          controller: bloc.searchController,
                          hintText: context.tr("Search services"),
                          onChanged: (value) {
                            bloc.add(SearchEvent(value));
                          },
                        ),
                      ],
                    ),
                    if (bloc.searchedServices.isNotEmpty) ...[
                      SizedBox(height: 32.h),

                      Padding(
                        padding: EdgeInsets.only(left: 32.w),
                        child: SizedBox(
                          height: 300.h,
                          width: context.getScreenWidth(size: 1.w),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bloc.searchedServices.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 300.h,
                                width: 230.w,
                                child: ServiceCard(
                                  service: bloc.searchedServices[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    /// 🔹 MAIN CATEGORIES
                    if (bloc.searchedServices.isEmpty) ...[
                      const SizedBox(height: 32),

                      Padding(
                        padding: EdgeInsets.only(left: 32.w),
                        child: SizedBox(
                          width: context.getScreenWidth(size: 1),
                          height: 90.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Categories(
                                  label: context.tr(categories[index]),
                                  svgIconPath: mainIcons[index],
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
                        height: 300.h,
                        width: context.getScreenWidth(size: 1.w),

                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          itemCount: bloc.supabaseConnect.services.where((
                            service,
                          ) {
                            return service.category == bloc.selectedCategory;
                          }).length,
                          itemBuilder: (context, index) {
                            final filteredServices = bloc
                                .supabaseConnect
                                .services
                                .where((service) {
                                  return service.category ==
                                      bloc.selectedCategory;
                                })
                                .toList();
                            final service = filteredServices[index];
                            return SizedBox(
                              width: 230.w,
                              height: 300.h,
                              child: ServiceCard(service: service),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
