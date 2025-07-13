import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:moyasar/moyasar.dart';

class BookingCard extends StatelessWidget {
  final Appointment appointment;
  final Function() onPay;

  const BookingCard({
    super.key,
    required this.appointment,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final paymentConfig = PaymentConfig(
      publishableApiKey: dotenv.env["MOYASAR_KEY"]!,
      amount: (appointment.service!.price * 100).toInt(), // SAR 257.58
      description: 'GlowUp Booking (${appointment.service?.name})',
      currency: 'SAR',
      applePay: ApplePayConfig(
        merchantId: 'glowup.com.mysr.apple',
        label: "GlowUp Booking (${appointment.service?.name})",
        manual: false,
        saveCard: false,
      ),
      creditCard: CreditCardConfig(saveCard: false, manual: false),
    );
    void showToast(context, status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Status: $status",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }

    void onPaymentResult(result) {
      if (result is PaymentResponse) {
        showToast(context, result.status.name);
        switch (result.status) {
          case PaymentStatus.paid:
            onPay();
            Navigator.of(context).pop(); // Close the dialog
            break;
          case PaymentStatus.failed:
            break;
          case PaymentStatus.authorized:
            break;
          default:
        }
        return;
      }

      // handle failures.
      if (result is ApiError) {
        showToast(context, result.message);
      }
      if (result is AuthError) {
        showToast(context, result.message);
      }
      if (result is ValidationError) {
        showToast(context, result.message);
      }
      if (result is PaymentCanceledError) {
        showToast(context, result.message);
      }
      if (result is UnprocessableTokenError) {
        showToast(context, result.message);
      }
      if (result is TimeoutError) {
        showToast(context, result.message);
      }
      if (result is NetworkError) {
        showToast(context, result.message);
      }
      if (result is UnspecifiedError) {
        showToast(context, result.message);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.service?.name ?? "Service",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
                ],
              ),
              Positioned(
                bottom: 0.h,
                right: 0.w,
                child: _StatusBadge(status: appointment.status),
              ),
            ],
          ),
          if (appointment.status == "Accepted") ...[
            SizedBox(height: 16.h),
            CustomElevatedButton(
              text: "Pay",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      title: Text("Payment"),
                      content: Text("Proceed with payment"),
                      actions: [
                        Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            children: [
                              if (Platform.isIOS)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: ApplePay(
                                    config: paymentConfig,
                                    onPaymentResult: onPaymentResult,
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
                              CreditCard(
                                config: paymentConfig,
                                onPaymentResult: onPaymentResult,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              width: 250,
              height: 30,
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
        Icon(icon, size: 18.sp),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 14.sp)),
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
        borderRadius: BorderRadius.circular(30.r),
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
