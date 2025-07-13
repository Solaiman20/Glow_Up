import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/profile/profile_dialog.dart';
import 'package:glowup/Screens/Customer/Help/help_screen.dart';
import 'package:glowup/Screens/Provider/Employees/my_employee_screen.dart';
import 'package:glowup/Screens/Provider/Profile/bloc/provider_profile_bloc.dart';
import 'package:glowup/Screens/Shared/splash/splash.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderProfileBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<ProviderProfileBloc>();
          if (context.locale == Locale("en")) {
            bloc.languageSwitchValue = 1;
          } else {
            bloc.languageSwitchValue = 0;
          }

          if (bloc.themeManager.themeMode == ThemeMode.light) {
            bloc.themeSwitchValue = 0;
          } else {
            bloc.themeSwitchValue = 1;
          }

          return BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
            builder: (context, state) {
              print(bloc.provider.avatarUrl);
              return BlocListener<ProviderProfileBloc, ProviderProfileState>(
                listener: (listenerContext, state) {
                  if (state is ProviderLoggingOut) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  }
                  if (state is ProviderLoggedOut) {
                    Navigator.pushReplacementNamed(context, '/onboarding');
                  }
                  if (state is LogOutError) {
                    ScaffoldMessenger.of(
                      listenerContext,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is ProviderAvatarSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Avatar updated successfully!"),
                      ),
                    );
                    bloc.add(UpdateUIEvent());
                  }
                  if (state is UpdateAvatarErrorState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is ProviderBannerSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Banner updated successfully!"),
                      ),
                    );
                  }
                  if (state is UpdateBannerErrorState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is UsernameUpdatedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Username updated successfully!"),
                      ),
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
                      const SnackBar(
                        content: Text("Email updated successfully!"),
                      ),
                    );
                  }
                  if (state is EmailUpdateErrorState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false, // May change
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
                                imageUrl: "${bloc.provider.bannerUrl}",
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
                              child: GestureDetector(
                                onTap: () {
                                  bloc.add(UpdateProviderAvatarEvent());
                                },
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          bloc.supabase.theProvider!.avatarUrl!,
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
                            ),
                            Positioned(
                              right: 0.w,
                              left: 85.w,
                              top: 75.h,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 72.h),

                        // The provider name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(),
                            Text(
                              bloc.provider.name,
                              style: AppFonts.semiBold24,
                            ),
                            Row(
                              children: [
                                Text("${bloc.provider.avgRating}"),
                                Icon(Icons.star, color: Colors.yellow.shade600),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomBackgroundContainer(
                          childWidget: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.person),
                                  title: Text(context.tr("Employees")),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: bloc,
                                              child: MyEmployeeScreen(),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                Divider(),
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
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
                                        textFieldHint: context.tr(
                                          "New Username",
                                        ),
                                        submitMethod: () {
                                          if (bloc.usernameKey.currentState!
                                              .validate()) {
                                            bloc.add(
                                              UpdateProviderUsernameEvent(
                                                bloc.usernameController.text
                                                    .trim(),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Divider(),
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.image_outlined),
                                  title: Text(context.tr("Banner")),
                                  onTap: () {
                                    bloc.add(UpdateProviderBannerEvent());
                                  },
                                ),
                                Divider(),
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
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
                                              UpdateProviderPhoneEvent(
                                                bloc.phoneNumberController.text
                                                    .trim(),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),

                                Divider(),
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.email_outlined),
                                  title: Text(context.tr("Email")),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ProfileDialog(
                                        containerHeight: 200,
                                        formKey: bloc.emailKey,
                                        textFieldController:
                                            bloc.emailController,
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
                                              UpdateProviderEmailEvent(
                                                bloc.emailController.text
                                                    .trim(),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Divider(),
                                // Navigate to Help Screen
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.help),
                                  title: Text(context.tr("Help")),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HelpScreen(),
                                      ),
                                    );
                                  },
                                ),
                                Divider(),

                                // Navigate to the Settings Screen
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.language),
                                  title: Text(context.tr("Language")),
                                  trailing: AnimatedToggleSwitch<int>.size(
                                    height: 35.h,
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
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(Icons.contrast),
                                  title: Text(context.tr("Theme")),
                                  trailing: AnimatedToggleSwitch.size(
                                    height: 35.h,
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
                                    onChanged: (_) async {
                                      bloc.add(ThemeSwitchToggleEvent());
                                    },
                                  ),
                                ),
                                Divider(),

                                // Add the Logout function
                                ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                    vertical: -0.5.h,
                                  ),
                                  leading: Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  title: Text(context.tr("Logout")),
                                  onTap: () {
                                    bloc.add(LogOutProvider());
                                  },
                                ),
                              ],
                            ),
                          ),
                          height: 550.h,
                          paddingSize: false,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
