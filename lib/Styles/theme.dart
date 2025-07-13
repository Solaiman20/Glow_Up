import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.goldenPeach,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.white,
  timePickerTheme: const TimePickerThemeData(
    backgroundColor: AppColors.background,
    hourMinuteTextColor: AppColors.darkText,
    dayPeriodTextColor: AppColors.darkText,
    dialBackgroundColor: AppColors.calendarDay,
    entryModeIconColor: AppColors.darkText,
  ),
  highlightColor: AppColors.calendarDay,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
  iconTheme: const IconThemeData(color: AppColors.darkText),
  useMaterial3: false,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.goldenPeachDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.cardDark,
  listTileTheme: const ListTileThemeData(
    textColor: AppColors.lightTextDark,
    iconColor: AppColors.lightTextDark,
  ),
  highlightColor: AppColors.cardDark,
  timePickerTheme: TimePickerThemeData(
    backgroundColor: AppColors.backgroundDark,
    hourMinuteTextColor: AppColors.lightTextDark,
    dayPeriodTextColor: AppColors.lightTextDark,
    dialBackgroundColor: AppColors.calendarDay,
    entryModeIconColor: AppColors.lightTextDark,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightTextDark),
    bodyMedium: TextStyle(color: AppColors.mutedTextDark),
  ),
  iconTheme: const IconThemeData(color: AppColors.lightTextDark),
  useMaterial3: false,
);
