part of 'employee_details_bloc.dart';

@immutable
sealed class EmployeeDetailsEvent {}

final class SelectDateEvent extends EmployeeDetailsEvent {
  final DateTime day;
  final DateTime focusedDay;

  SelectDateEvent(this.day, this.focusedDay);
}

final class SetStartTimeEvent extends EmployeeDetailsEvent {
  final TimeOfDay startTime;

  SetStartTimeEvent(this.startTime);
}

final class SetEndTimeEvent extends EmployeeDetailsEvent {
  final TimeOfDay endTime;

  SetEndTimeEvent(this.endTime);
}

final class EditStylistScheduleEvent extends EmployeeDetailsEvent {}
