import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_auth_container.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/first_page_view.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/second_page_view.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/third_page_view.dart';
import 'package:glowup/CustomWidgets/shared/ontap_text.dart';
import 'package:glowup/Screens/Customer/SignUp/bloc/sign_up_bloc.dart';
import 'package:glowup/Screens/Shared/Login/login_screen.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 48.h),
            Image.asset(
              "assets/images/logo1.png",
              height: 200.h,
              width: 200.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.h),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                final bloc = context.read<SignUpBloc>();
                return BackgroundContainer(
                  heightSize: 0.75,
                  childWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        context.tr(bloc.titleText[bloc.currentPage]),
                        style: AppFonts.semiBold24,
                      ),
                      SizedBox(height: 24.h),
                      SmoothPageIndicator(
                        controller: bloc.pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          radius: 16.r,
                          dotWidth: 58.w,
                          dotHeight: 8.h,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        height: 450.h,
                        width: (402 * 0.9).w,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: bloc.pageController,
                          children: [
                            FirstPageView(
                              formKey: bloc.signUpformKey,
                              nameController: bloc.nameController,
                              nameValidation: (value) {
                                final error = bloc.userNameValidation(
                                  text: value,
                                );
                                return error == null ? null : context.tr(error);
                              },
                              emailController: bloc.emailController,
                              emailValidation: (value) {
                                final error = bloc.emailValidation(text: value);
                                return error == null ? null : context.tr(error);
                              },
                              passwordController: bloc.passwordController,
                              passwordValidation: (value) {
                                final error = bloc.passwordValidation(
                                  text: value,
                                );
                                return error == null ? null : context.tr(error);
                              },
                              confirmPasswordController:
                                  bloc.confirmPasswordController,
                              confirmPasswordValidation: (value) {
                                final error = bloc.confrimPasswordValidation(
                                  text: value,
                                );
                                return error == null ? null : context.tr(error);
                              },
                              pressedMethod: () =>
                                  bloc.add(CreateAccountEvent()),
                            ),
                            SecondPageView(
                              formKey: bloc.locationFormKey,
                              controller: bloc.addressController,
                              pressedMethod: () =>
                                  bloc.add(SendConfermationEvent()),
                              addressValidation: (value) {
                                final error = bloc.addressValidation(
                                  text: value,
                                );
                                return error == null ? null : context.tr(error);
                              },
                            ),
                            ThirdPageView(),
                          ],
                        ),
                      ),
                      OntapText(
                        text: context.tr("Already have an account?  Login"),
                        pressedMethod: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
