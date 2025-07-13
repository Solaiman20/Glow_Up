part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class CategorySelectedState extends HomeState {
  CategorySelectedState();
}

final class SearchedServicesState extends HomeState {}

final class UIUpdatedState extends HomeState {}
