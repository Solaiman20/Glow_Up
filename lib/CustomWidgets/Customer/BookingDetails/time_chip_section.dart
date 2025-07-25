import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:glowup/Screens/Customer/BookingDetails/bloc/booking_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';

class TimeChipSection extends StatelessWidget {
  final String title;
  final List<DateTime> slots;
  final int durationMinutes;
  final Stylist stylist;

  const TimeChipSection({
    required this.title,
    required this.slots,
    required this.durationMinutes,
    required this.stylist,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
      builder: (context, state) {
        final bloc = context.read<BookingDetailsBloc>();
        return ExpansionTile(
          textColor: Colors.black,
          iconColor: Colors.black,
          title: Text(title),
          children: [
            Wrap(
              spacing: 4.r,
              runSpacing: 4.r,
              children: slots.map((time) {
                final label = DateFormat.Hm().format(time);

                return ChoiceChip(
                  label: Text(label),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  selectedColor: AppColors.goldenPeach,
                  backgroundColor: AppColors.calendarDay,
                  disabledColor: AppColors.disabledCalendarDay,
                  selected:
                      (bloc.selectedTime?.hour == time.hour &&
                      bloc.selectedTime?.minute == time.minute),
                  onSelected:
                      !bloc.supabase.isConflictingAppointment(
                        bloc.selectedDate!,
                        time,
                        durationMinutes,
                        stylist,
                      )
                      ? (selectedTime) {
                          bloc.add(SelectTimeEvent(time));
                          log(selectedTime.toString());
                        }
                      : null,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
