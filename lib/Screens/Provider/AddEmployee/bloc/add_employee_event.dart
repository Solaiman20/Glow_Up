part of 'add_employee_bloc.dart';

@immutable
sealed class AddEmployeeEvent {}

final class SubmitEvent extends AddEmployeeEvent {}
