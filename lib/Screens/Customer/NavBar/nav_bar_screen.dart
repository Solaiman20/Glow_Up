import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bookings_screen.dart';

import 'package:glowup/Screens/Customer/Providers/providers_screen.dart';
import 'package:glowup/Screens/Customer/NavBar/bloc/nav_bar_bloc.dart';
import 'package:glowup/Screens/Customer/Profile/profile_screen.dart';
import 'package:glowup/Screens/Customer/Services/home_screen.dart';

class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key});

  final List<String> svgPaths = const [
    'assets/svgs/home.svg',
    'assets/svgs/salons.svg',
    'assets/svgs/booking.svg',
    'assets/svgs/me.svg',
  ];

  List<String> labels = ["Home", "Providers", "Bookings", "Me"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavBarBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocBuilder<NavBarBloc, NavBarState>(
          builder: (context, state) {
            return Stack(
              children: [
                IndexedStack(
                  index: state.selectedIndex,
                  children: const [
                    HomeScreen(),
                    ProvidersScreen(),
                    BookingsScreen(),
                    ProfileScreen(),
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
                            context.read<NavBarBloc>().add(
                              ChangeTabEvent(index),
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
                                width: 24.w,
                                height: 24.h,
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
