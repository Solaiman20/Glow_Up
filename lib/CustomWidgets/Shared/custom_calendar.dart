import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatelessWidget {
  CustomCalendar({
    super.key,
    required this.stylist,
    required this.onDaySelected,
    this.currentDay,
    this.selectedDayPredicate,
  });
  final Stylist stylist;
  final DateTime? currentDay;
  final void Function(DateTime day, DateTime focusedDay) onDaySelected;
  final bool Function(DateTime)? selectedDayPredicate;

  @override
  Widget build(BuildContext context) {
    final availableDays = stylist.availabilitySlots.map((slot) {
      return DateTime.parse(slot.date);
    }).toList();

    return SizedBox(
      height: 430.h,
      width: 330.w,
      child: TableCalendar(
        locale: context.locale.toLanguageTag(),
        headerStyle: HeaderStyle(
          decoration: BoxDecoration(
            color: AppColors.calendarHeaderBackground.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
          ),
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: AppFonts.regular14.copyWith(
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Container(
            width: 102.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.goldenPeach,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios, color: AppColors.white, size: 16.sp),
                Text(
                  "Previous Month",
                  style: AppFonts.regular14.copyWith(
                    color: AppColors.white,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          rightChevronIcon: Container(
            width: 95.w,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.goldenPeach,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Next Month",
                  style: AppFonts.regular14.copyWith(
                    color: AppColors.white,
                    fontSize: 10.sp,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
        startingDayOfWeek: StartingDayOfWeek.sunday,
        weekendDays: [DateTime.friday, DateTime.saturday],
        calendarStyle: CalendarStyle(
          defaultTextStyle: AppFonts.regular14.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.daysOfWeekTextColor,
          ),
          weekendTextStyle: AppFonts.regular14.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.daysOfWeekTextColor,
          ),

          disabledTextStyle: AppFonts.regular14.copyWith(color: Colors.grey),
          todayTextStyle: AppFonts.regular14.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.daysOfWeekTextColor,
          ),
          defaultDecoration: BoxDecoration(
            color: AppColors.calendarDay,
            borderRadius: BorderRadius.circular(5.r),
          ),
          disabledDecoration: BoxDecoration(
            color: AppColors.disabledCalendarDay,
            borderRadius: BorderRadius.circular(5.r),
          ),
          weekendDecoration: BoxDecoration(
            color: AppColors.calendarDay,
            borderRadius: BorderRadius.circular(5.r),
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.softBrown,
            borderRadius: BorderRadius.circular(5.r),
          ),
          todayDecoration: BoxDecoration(
            color: AppColors.calendarDay,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppFonts.regular14.copyWith(
            color: AppColors.daysOfWeekTextColor.withValues(alpha: 0.6),
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: AppFonts.regular14.copyWith(
            color: AppColors.daysOfWeekTextColor.withValues(alpha: 0.6),
            fontWeight: FontWeight.bold,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),

        focusedDay: currentDay ?? DateTime.now(),
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 30)),
        currentDay: DateTime.now(),
        selectedDayPredicate: selectedDayPredicate,
        enabledDayPredicate: (day) {
          final d = DateTime(day.year, day.month, day.day);
          return availableDays.contains(d);
        },
        onDaySelected: onDaySelected,
      ),
    );
  }
}
