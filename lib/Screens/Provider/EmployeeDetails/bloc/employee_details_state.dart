part of 'employee_details_bloc.dart';

@immutable
sealed class EmployeeDetailsState {}

final class EmployeeDetailsInitial extends EmployeeDetailsState {}

final class DateSelectedState extends EmployeeDetailsState {}

final class TimeSelectedState extends EmployeeDetailsState {}

final class ScheduleEditedState extends EmployeeDetailsState {}

final class ScheduleEditErrorState extends EmployeeDetailsState {
  final String error;

  ScheduleEditErrorState(this.error);
}
