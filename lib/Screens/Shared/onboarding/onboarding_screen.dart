import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/button.dart';
import 'package:glowup/Screens/Shared/Onboarding/bloc/onboarding_bloc.dart';
import 'package:glowup/Styles/app_font.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (listenerContext, state) {},
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 200.h),
                Image.asset(
                  "assets/images/logo2.png",
                  height: 200.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
                Text(context.tr("Beauty at Your Fingertips") , style: AppFonts.semiBold24),
                SizedBox(height: 10.h),
                Text(context.tr("Browse top-rated salons near") , style: AppFonts.regular22),
                SizedBox(height: 5.h),
                Text(
                  context.tr("you and find services that fit ")
                  ,
                  style: AppFonts.regular22,
                ),
                SizedBox(height: 5.h),
                Text(
                  context.tr("your style fast and very easy"),
                  style: AppFonts.regular22,
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  text: context.tr("Login"),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: context.tr("Sign Up"),
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/providerSignup');
                  },
                  child: Text(
                    context.tr("Are you a Provider? Register here"),
                    style: AppFonts.regular14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
