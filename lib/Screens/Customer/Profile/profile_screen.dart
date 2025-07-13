import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/profile/profile_dialog.dart';
import 'package:glowup/Screens/Customer/Help/help_screen.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_bloc.dart';
import 'package:glowup/Screens/Shared/splash/splash.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (listenerContext, state) {
          final bloc = listenerContext.read<ProfileBloc>();
          if (state is UserLoggingOut) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          }
          if (state is UserLoggedOut) {
            Navigator.pushReplacementNamed(context, '/onboarding');
          }
          if (state is LogOutError) {
            ScaffoldMessenger.of(
              listenerContext,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UserAvatarUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Avatar updated successfully!")),
            );
            bloc.add(LoadProfileAvatar());
          }
          if (state is UpdateAvatarError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UsernameUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Username updated successfully!")),
            );
          }
          if (state is UsernameUpdateErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is PhoneNumberUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Phone number updated successfully!"),
              ),
            );
          }
          if (state is PhoneNumberUpdateErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is EmailUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email updated successfully!")),
            );
          }
          if (state is EmailUpdateErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final bloc = context.read<ProfileBloc>();
              if (context.locale == Locale("en")) {
                bloc.languageSwitchValue = 1;
              } else {
                bloc.languageSwitchValue = 0;
              }

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    GestureDetector(
                      onTap: () {
                        bloc.add(UpdateUserAvatar());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: CachedNetworkImage(
                          imageUrl: bloc.supabase.userProfile!.avatarUrl!,
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
                    SizedBox(height: 20.h),
                    Text(
                      bloc.supabase.userProfile!.username!,
                      style: AppFonts.semiBold24,
                    ),

                    SizedBox(height: 20),
                    CustomBackgroundContainer(
                      childWidget: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.badge_outlined),
                              title: Text(context.tr("Name")),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProfileDialog(
                                    containerHeight: 200,
                                    formKey: bloc.usernameKey,
                                    textFieldController:
                                        bloc.usernameController,
                                    controllerValidation: (value) {
                                      final error = bloc.userNameValidation(
                                        text: value,
                                      );
                                      return error == null
                                          ? null
                                          : context.tr(error);
                                    },
                                    textFieldHint: context.tr("New Username"),
                                    submitMethod: () {
                                      if (bloc.usernameKey.currentState!
                                          .validate()) {
                                        bloc.add(
                                          UpdateUsernameEvent(
                                            bloc.usernameController.text,
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Divider(color: Colors.amber),
                            ),

                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(context.tr("Number")),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProfileDialog(
                                    containerHeight: 200,
                                    formKey: bloc.phoneNumberKey,
                                    textFieldController:
                                        bloc.phoneNumberController,
                                    controllerValidation: (value) {
                                      final error = bloc.phoneValidation(
                                        text: value,
                                      );
                                      return error == null
                                          ? null
                                          : context.tr(error);
                                    },
                                    textFieldHint: context.tr(
                                      "New Phone Number",
                                    ),
                                    submitMethod: () {
                                      if (bloc.phoneNumberKey.currentState!
                                          .validate()) {
                                        bloc.add(
                                          UpdatePhoneEvent(
                                            bloc.phoneNumberController.text,
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.email_outlined),
                              title: Text(context.tr("Email")),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProfileDialog(
                                    containerHeight: 200,
                                    formKey: bloc.emailKey,
                                    textFieldController: bloc.emailController,
                                    controllerValidation: (value) {
                                      final error = bloc.emailValidation(
                                        text: value,
                                      );
                                      return error == null
                                          ? null
                                          : context.tr(error);
                                    },
                                    textFieldHint: context.tr("New Email"),
                                    submitMethod: () {
                                      if (bloc.emailKey.currentState!
                                          .validate()) {
                                        bloc.add(
                                          UpdateEmailEvent(
                                            bloc.emailController.text,
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Divider(),
                            // Navigate to Help Screen
                            ListTile(
                              leading: Icon(Icons.help),
                              title: Text(context.tr("Help")),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const HelpScreen(),
                                  ),
                                );
                              },
                            ),
                            Divider(),

                            // Navigate to the Settings Screen
                            ListTile(
                              leading: Icon(Icons.language),
                              title: Text(context.tr("Language")),
                              trailing: AnimatedToggleSwitch<int>.size(
                                height: 40.h,
                                current: bloc.languageSwitchValue,
                                values: [0, 1],
                                style: ToggleStyle(
                                  borderColor: AppColors.goldenPeach,
                                  backgroundColor: AppColors.background,
                                  indicatorColor: AppColors.goldenPeach,
                                ),

                                iconList: [
                                  Text(
                                    "العربية",
                                    style: AppFonts.regular14.copyWith(
                                      fontSize: 10.sp,
                                      color: bloc.languageSwitchValue == 0
                                          ? AppColors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "English",
                                    style: AppFonts.regular14.copyWith(
                                      fontSize: 10.sp,
                                      color: bloc.languageSwitchValue == 1
                                          ? AppColors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                                onChanged: (_) {
                                  if (context.locale == Locale("en")) {
                                    context.setLocale(Locale("ar"));
                                  } else {
                                    context.setLocale(Locale("en"));
                                  }
                                  bloc.add(LanguageSwitchToggleEvent());
                                },
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.contrast),
                              title: Text(context.tr("Theme")),
                              trailing: AnimatedToggleSwitch.size(
                                height: 40.h,
                                current: bloc.themeSwitchValue,
                                values: [0, 1],
                                style: ToggleStyle(
                                  borderColor: AppColors.goldenPeach,
                                  backgroundColor: AppColors.background,
                                  indicatorColor: AppColors.goldenPeach,
                                ),
                                iconList: [
                                  Icon(
                                    Icons.light_mode,
                                    color: bloc.themeSwitchValue == 0
                                        ? Colors.yellow.shade700
                                        : Colors.black,
                                  ),
                                  Icon(
                                    Icons.dark_mode,
                                    color: bloc.themeSwitchValue == 1
                                        ? AppColors.white
                                        : Colors.black,
                                  ),
                                ],
                                onChanged: (_) =>
                                    bloc.add(ThemeSwitchToggleEvent()),
                              ),
                            ),
                            Divider(),

                            // Add the Logout function
                            ListTile(
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text(context.tr("Logout")),

                              onTap: () {
                                bloc.add(LogOutUser());
                              },
                            ),
                          ],
                        ),
                      ),
                      height: 520,
                      paddingSize: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
