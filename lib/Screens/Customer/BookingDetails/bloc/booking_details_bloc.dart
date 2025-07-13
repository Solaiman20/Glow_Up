import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:meta/meta.dart';

part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  Stylist? selectedStylist;
  DateTime? selectedDate = DateTime.now();
  DateTime? selectedTime;
  int? startTime;

  int chipsLength = 0;
  BookingDetailsBloc() : super(BookingDetailsInitial()) {
    on<BookingDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChooseStylistEvent>((event, emit) {
      selectedStylist = event.stylist;
      emit(StylistSelectedState());
    });
    on<SelectDateEvent>((event, emit) {
      selectedDate = event.day;
      selectedTime = null;
      if (selectedStylist?.availabilitySlots != null &&
          selectedStylist!.availabilitySlots.isNotEmpty) {
        var availableSlot = selectedStylist!.availabilitySlots.where((slot) {
          return "${DateTime.parse(slot.date).month}/${DateTime.parse(slot.date).day}" ==
              "${event.focusedDay.month}/${event.focusedDay.day}";
        }).first;

        final format = DateFormat('HH:mm');
        var startingTime = format.parse(availableSlot.startTime);
        var endTime = format.parse(availableSlot.endTime);
        var timeLength = endTime.difference(startingTime);
        startTime = startingTime.hour * 60;

        chipsLength = timeLength.inMinutes ~/ 30;
      }

      emit(DateSelectedState());
    });
    on<SelectTimeEvent>((event, emit) {
      var format = DateFormat('HH:mm');
      selectedTime = format.parse(event.label);

      log("Selected time: ${selectedTime!.hour}:${selectedTime!.minute}");
      emit(TimeSelectedState());
    });
    on<BookAppointmentEvent>((event, emit) async {
      await supabase.bookAppointment(
        appointmentDate: selectedDate!.toIso8601String(),
        appointmentStart: selectedTime!.toIso8601String(),
        appointmentEnd: selectedTime!
            .add(Duration(minutes: event.service.durationMinutes))
            .toIso8601String(),
        stylistId: selectedStylist!.id!,
        serviceId: event.service.id!,
        providerId: event.service.providerId,
        atHome: event.service.atHome,
      );
      Navigator.of(event.context).pop();
      selectedDate = DateTime.now();
      selectedTime = null;
      startTime = null;
      selectedStylist = null;
    });
  }
}
