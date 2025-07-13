import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Screens/Provider/p_booking/p_booking_screen.dart';
import 'package:glowup/Screens/Provider/NavBar/bloc/provider_nav_bar_bloc.dart';

import 'package:glowup/Screens/Provider/Profile/provider_profile_screen.dart';
import 'package:glowup/Screens/Provider/Services/provider_services_screen.dart';

class ProviderNavBarScreen extends StatelessWidget {
  const ProviderNavBarScreen({super.key});

  final List<String> svgPaths = const [
    'assets/svgs/home.svg',
    'assets/svgs/booking.svg',
    'assets/svgs/me.svg',
  ];

  final List<String> labels = const ["Services", "Bookings", "Me"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderNavBarBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF2E3C6),
        body: BlocBuilder<ProviderNavBarBloc, ProviderNavBarState>(
          builder: (context, state) {
            return Stack(
              children: [
                IndexedStack(
                  index: state.selectedIndex,
                  children: [
                    ProviderServicesScreen(),
                    PBookingsScreen(),
                    ProviderProfileScreen(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 390.w,
                    height: 70.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(svgPaths.length, (index) {
                        final isActive = state.selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            context.read<ProviderNavBarBloc>().add(
                              ChangeProviderTabEvent(index),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                svgPaths[index],
                                colorFilter: ColorFilter.mode(
                                  isActive
                                      ? const Color(0xFF8A766D)
                                      : const Color(0xFFCBB9A8),
                                  BlendMode.srcIn,
                                ),
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                context.tr(labels[index]),
                                style: TextStyle(
                                  color: isActive
                                      ? const Color(0xFF8A766D)
                                      : const Color(0xFFCBB9A8),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
