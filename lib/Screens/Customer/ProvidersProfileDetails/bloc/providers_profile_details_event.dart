part of 'providers_profile_details_bloc.dart';

@immutable
sealed class ProvidersProfileDetailsEvent {}

final class CategorySelectEvent extends ProvidersProfileDetailsEvent {
  final int index;
  CategorySelectEvent(this.index);
}
