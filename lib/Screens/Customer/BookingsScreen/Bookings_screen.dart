import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Booking/booking_card.dart';
import 'package:glowup/CustomWidgets/shared/status_toggle.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_bloc.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc()..add(UpdateUIEvent()),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          final bloc = context.read<BookingBloc>();
          bloc.add(SubscribeToStreamEvent());
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h),

                    StatusToggle(
                      selectedIndex: bloc.selectedIndex,
                      onSelected: (int index) {
                        context.read<BookingBloc>().add(
                          StatusToggleEvent(index),
                        );
                      },
                    ),

                    SizedBox(height: 24.h),
                    // You can add filtered list or content below here
                    if (bloc.appointmentsMap[bloc.selectedIndex] == null ||
                        bloc.appointmentsMap[bloc.selectedIndex]!.isEmpty)
                      Center(
                        child: Text(
                          "No bookings available",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    if (bloc.appointmentsMap[bloc.selectedIndex] != null &&
                        bloc.appointmentsMap[bloc.selectedIndex]!.isNotEmpty)
                      ...List.generate(
                        bloc.appointmentsMap[bloc.selectedIndex]!.length,
                        (index) {
                          final appointments =
                              bloc.appointmentsMap[bloc.selectedIndex] ?? [];
                          return BookingCard(
                            appointment: appointments[index],
                            onPay: () {
                              bloc.add(
                                ServicePayEvent(appointments[index].id!),
                              );
                            },
                          );
                        },
                      ),
                    SizedBox(height: 60.h),
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
