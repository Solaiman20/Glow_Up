import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/Booking/p_booking_card.dart';

import 'package:glowup/CustomWidgets/shared/status_toggle.dart';

import 'package:glowup/Screens/Provider/p_booking/bloc/p_booking_bloc.dart';

class PBookingsScreen extends StatelessWidget {
  const PBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PBookingBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<PBookingBloc>();
          bloc.add(SubscribeToStreamEvent());
          return BlocBuilder<PBookingBloc, PBookingState>(
            builder: (context, state) {
              return BlocListener<PBookingBloc, PBookingState>(
                listener: (context, state) {
                  if (state is ErrorUpdatingStream) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is CompleteAppointmentSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  if (state is CompleteAppointmentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatusToggle(
                              selectedIndex: bloc.selectedIndex,
                              onSelected: (int index) {
                                context.read<PBookingBloc>().add(
                                  PStatusToggleChanged(index),
                                );
                              },
                            ),

                            SizedBox(height: 24.h),
                            if (bloc.appointmentsMap[bloc.selectedIndex] ==
                                    null ||
                                bloc
                                    .appointmentsMap[bloc.selectedIndex]!
                                    .isEmpty)
                              Center(
                                child: Text(
                                  "No bookings available",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            if (bloc.appointmentsMap[bloc.selectedIndex] !=
                                    null &&
                                bloc
                                    .appointmentsMap[bloc.selectedIndex]!
                                    .isNotEmpty)
                              ...List.generate(
                                bloc
                                    .appointmentsMap[bloc.selectedIndex]!
                                    .length,
                                (index) {
                                  final appointments =
                                      bloc.appointmentsMap[bloc
                                          .selectedIndex] ??
                                      [];
                                  return PBookingCard(
                                    appointment: appointments[index],
                                    onAccept: () => bloc.add(
                                      AcceptAppointmentEvent(
                                        bloc.appointmentsMap[bloc
                                            .selectedIndex]![index],
                                      ),
                                    ),
                                    onDecline: () => bloc.add(
                                      RejectAppointmentEvent(
                                        bloc.appointmentsMap[bloc
                                            .selectedIndex]![index],
                                      ),
                                    ),
                                    onComplete: () => bloc.add(
                                      CompleteAppointmentEvent(
                                        bloc.appointmentsMap[bloc
                                            .selectedIndex]![index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            SizedBox(height: 60.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
