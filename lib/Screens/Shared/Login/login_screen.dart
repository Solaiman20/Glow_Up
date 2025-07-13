import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:glowup/CustomWidgets/shared/custom_auth_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/onTap_text.dart';
import 'package:glowup/Screens/Customer/NavBar/nav_bar_screen.dart';
import 'package:glowup/Screens/Provider/NavBar/provider_nav_bar_screen.dart';
import 'package:glowup/Screens/Shared/Login/bloc/login_bloc.dart';
import 'package:glowup/Styles/app_font.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<LoginBloc>();
          return BlocListener<LoginBloc, LoginState>(
            listener: (listenerContext, state) {
              if (state is CustomerLoggedIn) {
                Navigator.pushReplacement(
                  listenerContext,
                  MaterialPageRoute(builder: (context) => NavBarScreen()),
                );
              }
              if (state is ProviderLoggedIn) {
                Navigator.pushReplacement(
                  listenerContext,
                  MaterialPageRoute(
                    builder: (context) => ProviderNavBarScreen(),
                  ),
                );
              }
              if (state is ErrorState) {
                ScaffoldMessenger.of(
                  listenerContext,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  SizedBox(height: 64.h),

                  Image.asset(
                    "assets/images/logo1.png",
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                  Spacer(),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return BackgroundContainer(
                        heightSize: 0.7,
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(),
                            Text(
                              context.tr("Welcome Back"),
                              style: AppFonts.semiBold24,
                            ),
                            SizedBox(),
                            Form(
                              key: bloc.loginFormKey,
                              child: Column(
                                children: [
                                  CustomTextfield(
                                    textFieldHint: context.tr("Email"),
                                    textFieldcontroller: bloc.emailController,
                                    validationMethod: (value) {
                                      final error = bloc.emailValidation(
                                        text: value,
                                      );
                                      return error == null
                                          ? null
                                          : context.tr(error);
                                    },
                                  ),
                                  CustomTextfield(
                                    textFieldHint: context.tr("Password"),
                                    isPassword: true,
                                    textFieldcontroller:
                                        bloc.passwordController,
                                    validationMethod: (value) {
                                      final error = bloc.passwordValidation(
                                        text: value,
                                      );
                                      return error == null
                                          ? null
                                          : context.tr(error);
                                    },
                                  ),
                                ],
                              ),
                            ),

                            CustomElevatedButton(
                              text: context.tr("Login"),
                              onTap: () {
                                bloc.add(ValidateLogin(context: context));
                              },
                            ),

                            OntapText(
                              text: context.tr(
                                "Don't have an account?  SignUp",
                              ),
                              pressedMethod: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      );
                    },
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
