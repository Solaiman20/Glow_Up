import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/EmployeeDetails/employee_custom_calendar.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:glowup/Screens/Provider/EmployeeDetails/bloc/employee_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class EmployeeDetails extends StatelessWidget {
  final Stylist stylist;
  const EmployeeDetails({super.key, required this.stylist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeDetailsBloc(stylist: stylist),
      child: BlocBuilder<EmployeeDetailsBloc, EmployeeDetailsState>(
        builder: (context, state) {
          final bloc = context.read<EmployeeDetailsBloc>();

          return BlocListener<EmployeeDetailsBloc, EmployeeDetailsState>(
            listener: (context, state) {
              if (state is ScheduleEditedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Schedule updated successfully".tr()),
                    backgroundColor: AppColors.backgroundDark,
                  ),
                );
              } else if (state is ScheduleEditErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppColors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDark,
                      ),
                      width: context.getScreenWidth(size: 1),
                      height: 150.h,
                      child: CachedNetworkImage(
                        imageUrl: "${bloc.supabase.theProvider!.bannerUrl}",
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.calendarDay,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image, color: AppColors.white),
                        height: 150.h,
                        width: context.getScreenWidth(size: 1.w),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 64.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 120.w),
                        Text(stylist.name, style: AppFonts.semiBold24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              stylist.avgRating == null
                                  ? Text("No Rating".tr())
                                  : Text("${stylist.avgRating}"),
                              Icon(Icons.star, color: Colors.yellow.shade600),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 48.h),

                    CustomBackgroundContainer(
                      childWidget: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Text(stylist.bio!, style: AppFonts.medium18),
                      ),
                      height: 150,
                    ),
                    SizedBox(height: 24.h),
                    ListTile(
                      leading: Icon(Icons.play_arrow),
                      title: Text(
                        bloc.startTime?.format(context) ?? "Pick start time",
                      ),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,

                          initialTime: TimeOfDay(hour: 9, minute: 0),
                        );
                        if (time != null) {
                          bloc.add(SetStartTimeEvent(time));
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.stop),
                      title: Text(
                        bloc.endTime?.format(context) ?? "Pick end time",
                      ),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 17, minute: 0),
                        );
                        if (time != null) {
                          bloc.add(SetEndTimeEvent(time));
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    EmployeeCustomCalendar(
                      stylist: stylist,
                      onDaySelected: (day, focusedday) {
                        bloc.add(SelectDateEvent(day, focusedday));
                      },
                      selectedDayPredicate: (day) {
                        return bloc.selectedDates.any(
                          (d) =>
                              d.year == day.year &&
                              d.month == day.month &&
                              d.day == day.day,
                        );
                      },
                    ),

                    SizedBox(height: 24.h),

                    // CustomCalendar(stylist: stylist, onDaySelected: onDaySelected, currentDay: currentDay)
                    CustomElevatedButton(
                      text: "Edit Availability",
                      onTap: () {
                        bloc.add(EditStylistScheduleEvent());
                      },
                    ), // Editing the schedule
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
