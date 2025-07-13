part of 'add_employee_bloc.dart';

@immutable
sealed class AddEmployeeState {}

final class AddEmployeeInitial extends AddEmployeeState {}

final class SuccessState extends AddEmployeeState {}

final class ErrorState extends AddEmployeeState {}



