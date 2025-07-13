import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Screens/Customer/Help/help_screen.dart';
import 'package:glowup/Screens/Customer/NavBar/nav_bar_screen.dart';
import 'package:glowup/Screens/Provider/NavBar/provider_nav_bar_screen.dart';
import 'package:glowup/Screens/Provider/SignUp/provider_sign_up_screen.dart';
import 'package:glowup/Screens/Shared/Login/login_screen.dart';
import 'package:glowup/Screens/Shared/Onboarding/onboarding_screen.dart';
import 'package:glowup/Screens/Shared/splash/splash.dart';
import 'package:glowup/Screens/Customer/SignUp/sign_up_screen.dart';
import 'package:glowup/Styles/theme.dart';
import 'package:glowup/Utilities/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: "assets/translations",
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final supabase = GetIt.I.get<SupabaseConnect>();
  final loggedIn = GetIt.I.get<SupabaseConnect>().userProfile != null;

  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = GetIt.I.get<ThemeManager>();

    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, _) {
        return ScreenUtilInit(
          designSize: const Size(402, 952),

          splitScreenMode: false,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            showSemanticsDebugger: false,
            debugShowMaterialGrid: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeManager.themeMode,
            initialRoute: loggedIn
                ? (supabase.userProfile?.role == "customer"
                      ? '/navbar'
                      : '/providernavbar')
                : '/splashscreen',
            routes: {
              '/splashscreen': (context) => const SplashScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/login': (context) => const LoginScreen(),
              '/navbar': (context) => NavBarScreen(),
              '/providerSignup': (context) => const ProviderSignUpScreen(),
              '/providernavbar': (context) => const ProviderNavBarScreen(),
              '/help': (context) => const HelpScreen(),
            },
          ),
        );
      },
    );
  }
}
