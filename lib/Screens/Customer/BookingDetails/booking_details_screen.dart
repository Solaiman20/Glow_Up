import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/BookingDetails/service_description.dart';
import 'package:glowup/CustomWidgets/Shared/custom_calendar.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Screens/Customer/BookingDetails/bloc/booking_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key, required this.service});
  final Services service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingDetailsBloc()..add(ChooseStylistEvent(service.stylists.first)),
      child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
        builder: (context, state) {
          final bloc = context.read<BookingDetailsBloc>();
          log(bloc.chipsLength.toString());
          bool showButton =
              bloc.selectedDate != null &&
              bloc.selectedTime != null &&
              bloc.selectedStylist != null;

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  ServiceDescription(service: service),
                  SizedBox(height: 16.h),
                  Container(
                    height: 900.h,
                    width: 370.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        Text("Choose your beauty technician"),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 50.h,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: service.stylists.length,
                              itemBuilder: (context, index) {
                                final stylist = service.stylists[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: ChoiceChip(
                                    backgroundColor: AppColors.paleYellow,
                                    selectedColor: AppColors.softBrown,
                                    label: Text(stylist.name),
                                    selected: bloc.selectedStylist == stylist,
                                    onSelected: (selected) {
                                      if (selected) {
                                        bloc.add(ChooseStylistEvent(stylist));
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.ratingBackground,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  bloc.selectedStylist?.avgRating
                                          ?.toStringAsFixed(1) ??
                                      "No Rating",
                                  style: AppFonts.regular22.copyWith(
                                    fontSize: 32.sp,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      itemBuilder: (_, __) => Icon(
                                        Icons.star,
                                        color: AppColors.ratingStars,
                                      ),
                                      direction: Axis.horizontal,
                                      rating:
                                          bloc.selectedStylist?.avgRating ?? 0,
                                      itemSize: 16.sp,
                                    ),
                                    Text(
                                      "(${bloc.selectedStylist?.ratingCount?.toString() ?? "0"})",
                                      style: AppFonts.light16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Add your calendar or additional widgets here.
                        SizedBox(height: 16.h),
                        CustomCalendar(
                          stylist:
                              bloc.selectedStylist ?? service.stylists.first,
                          currentDay: bloc.selectedDate!,
                          onDaySelected: (day, focusedDay) {
                            bloc.add(SelectDateEvent(day, focusedDay));
                          },
                          selectedDayPredicate: (day) =>
                              isSameDay(day, bloc.selectedDate),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 24.w,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Choose time", style: AppFonts.bold20),
                          ),
                        ),
                        SizedBox(
                          height: 200.h,
                          width: 370.w,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.w,
                              children: List.generate(bloc.chipsLength, (
                                index,
                              ) {
                                final addedMinutes = index * 30;
                                final totalMinutes =
                                    bloc.startTime! + addedMinutes;
                                final hours = totalMinutes ~/ 60;
                                final minutes = totalMinutes % 60;
                                final label =
                                    "$hours:${minutes.toString().padLeft(2, '0')}";
                                return Padding(
                                  padding: EdgeInsets.all(4.w),
                                  child: ChoiceChip(
                                    label: Text(label),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    selected:
                                        (bloc.selectedTime?.hour == hours &&
                                        bloc.selectedTime?.minute == minutes),
                                    selectedColor: AppColors.goldenPeach,
                                    backgroundColor: AppColors.calendarDay,
                                    disabledColor:
                                        AppColors.disabledCalendarDay,
                                    onSelected:
                                        bloc.supabase.isConflictingAppointment(
                                          bloc.selectedDate!,
                                          TimeOfDay(
                                            hour: hours,
                                            minute: minutes,
                                          ),
                                          bloc.selectedStylist!,
                                        )
                                        ? null
                                        : (value) {
                                            bloc.add(SelectTimeEvent(label));
                                          },
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                  CustomElevatedButton(
                    text: "Book Appointment",
                    onTap: showButton
                        ? () {
                            bloc.add(BookAppointmentEvent(service, context));
                          }
                        : null,
                  ),
                  SizedBox(height: 48.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
