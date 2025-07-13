import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';
import 'package:glowup/Repositories/models/availability_slot.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:meta/meta.dart';

part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc
    extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  final supabase = GetIt.I.get<SupabaseConnect>();
  final Set<DateTime> selectedDates = {};
  final Set<String> _originalDatesStrings = {};

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  EmployeeDetailsBloc({required Stylist stylist})
    : super(EmployeeDetailsInitial()) {
    for (var slot in stylist.availabilitySlots) {
      selectedDates.add(DateTime.parse(slot.date));
      _originalDatesStrings.add(slot.date);
    }
    on<SelectDateEvent>((event, emit) {
      final normalized = DateTime(
        event.day.year,
        event.day.month,
        event.day.day,
      );
      if (!selectedDates.contains(normalized)) {
        selectedDates.add(normalized);
      } else {
        selectedDates.removeWhere(
          (d) =>
              d.year == normalized.year &&
              d.month == normalized.month &&
              d.day == normalized.day,
        );
      }
      emit(DateSelectedState());
    });
    on<SetStartTimeEvent>((event, emit) {
      startTime = event.startTime;
      emit(TimeSelectedState());
    });
    on<SetEndTimeEvent>((event, emit) {
      endTime = event.endTime;
      emit(TimeSelectedState());
    });
    on<EditStylistScheduleEvent>((event, emit) async {
      try {
        if (startTime != null && endTime != null) {
          List<AvailabilitySlot> availabilityDatesAndTimes = [];
          for (var date in selectedDates) {
            final availabilitySlot = AvailabilitySlot(
              date:
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
              stylistId: stylist.id!,
              startTime:
                  "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}",
              endTime:
                  "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}",
            );
            availabilityDatesAndTimes.add(availabilitySlot);
          }
          final newDateStrings = availabilityDatesAndTimes
              .map((s) => s.date)
              .toSet();
          final removedDates = _originalDatesStrings
              .difference(newDateStrings)
              .toList();
          if (removedDates.isNotEmpty) {
            final deleteStatus = await supabase.deleteAvailabilitySlots(
              stylistId: stylist.id!,
              dates: removedDates,
            );
            if (!deleteStatus) {
              emit(ScheduleEditErrorState("Failed to delete schedule"));
              return;
            }
          }

          final editStatus = await supabase.editStylistSchedule(
            stylist: stylist,
            availabilityDatesAndTimes: availabilityDatesAndTimes,
          );
          if (editStatus) {
            emit(ScheduleEditedState());
          } else {
            emit(ScheduleEditErrorState("Failed to edit schedule"));
          }
        }
      } catch (e) {
        emit(ScheduleEditErrorState("An error occurred: ${e.toString()}"));
      }
    });
  }
}
