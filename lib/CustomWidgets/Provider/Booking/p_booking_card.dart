import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Styles/app_colors.dart';

class PBookingCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onComplete;
  final void Function(double) onCustomerRatingUpdate;
  final void Function()? onRate;
  final bool alreadyRated;

  const PBookingCard({
    super.key,
    required this.appointment,
    required this.onAccept,
    required this.onDecline,
    required this.onComplete,
    required this.onCustomerRatingUpdate,
    required this.onRate,
    required this.alreadyRated,
  });

  bool get isPending => appointment.status.toLowerCase() == 'pending';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Service",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.darkText,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: appointment.appointmentDate,
                  ),
                  SizedBox(height: 8.h),
                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    text:
                        "${appointment.appointmentStart} - ${appointment.appointmentEnd}",
                  ),
                  SizedBox(height: 8.h),
                  _InfoRow(
                    icon: Icons.person_outline,
                    text: appointment.stylist?.name ?? "Stylist",
                  ),
                  SizedBox(height: 8.h),
                  _InfoRow(
                    icon: Icons.store_outlined,
                    text: appointment.provider?.name ?? "Salon",
                  ),
                  if (isPending) ...[
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: onDecline,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Decline"),
                        ),
                        SizedBox(width: 10.w),
                        ElevatedButton(
                          onPressed: onAccept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Accept"),
                        ),
                      ],
                    ),
                  ],
                  if (appointment.status == "Paid") ...[
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      text: "Completed",
                      onTap: onComplete,
                      width: 250,
                      height: 30,
                    ),
                  ],
                ],
              ),
              Positioned(
                bottom: isPending ? 48.h : 0,
                right: 0,
                child: _StatusBadge(status: appointment.status),
              ),
            ],
          ),
          if (appointment.status == "Completed" && !alreadyRated) ...[
            SizedBox(height: 16.h),
            Center(child: Text("Rate The Customer")),
            Center(
              child: RatingBar.builder(
                itemSize: 30.sp,
                allowHalfRating: true,
                itemBuilder: (context, index) {
                  return Icon(Icons.star, color: Colors.amber);
                },
                onRatingUpdate: onCustomerRatingUpdate,
                tapOnlyMode: true,
              ),
            ),

            SizedBox(height: 16.h),
            Center(
              child: CustomElevatedButton(
                text: "Rate",
                onTap: onRate!,
                width: 250,
                height: 30,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColors.darkText),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, color: AppColors.darkText),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  Color _getColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.orange;
      case 'confirmed':
        return AppColors.green;
      case 'cancelled':
        return Colors.red;
      case 'paid':
        return AppColors.purple;
      case 'completed':
        return AppColors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getColor(status),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
