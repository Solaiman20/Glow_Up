part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class CategorySelectEvent extends HomeEvent {
  final int index;
  CategorySelectEvent(this.index);
}

final class LoadHomeEvent extends HomeEvent {}

final class SearchEvent extends HomeEvent {
  final String query;
  SearchEvent(this.query);
}

final class UpdateUIEvent extends HomeEvent {}
