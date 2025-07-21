import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/BookingDetails/service_description.dart';
import 'package:glowup/CustomWidgets/Customer/BookingDetails/time_chip_section.dart';
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
                            bloc.add(SelectDateEvent(day, focusedDay, service));
                          },
                          selectedDayPredicate: (day) =>
                              isSameDay(day, bloc.selectedDate),
                        ),
                        if (bloc.dateSelected)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 24.w,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Choose time",
                                style: AppFonts.bold20,
                              ),
                            ),
                          ),
                        if (bloc.dateSelected)
                          SizedBox(
                            width: 370.w,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlocProvider.value(
                                    value: bloc,
                                    child: TimeChipSection(
                                      title: "Morning",

                                      slots: bloc.timeChips
                                          .where((t) => t.hour < 12)
                                          .toList(),

                                      durationMinutes: service.durationMinutes,
                                      stylist: bloc.selectedStylist!,
                                    ),
                                  ),
                                  BlocProvider.value(
                                    value: bloc,
                                    child: TimeChipSection(
                                      title: "Afternoon",
                                      slots: bloc.timeChips
                                          .where(
                                            (t) => t.hour >= 12 && t.hour < 18,
                                          )
                                          .toList(),

                                      durationMinutes: service.durationMinutes,
                                      stylist: bloc.selectedStylist!,
                                    ),
                                  ),
                                  BlocProvider.value(
                                    value: bloc,
                                    child: TimeChipSection(
                                      title: "Evening",
                                      slots: bloc.timeChips
                                          .where((t) => t.hour >= 18)
                                          .toList(),

                                      durationMinutes: service.durationMinutes,
                                      stylist: bloc.selectedStylist!,
                                    ),
                                  ),
                                ],
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
