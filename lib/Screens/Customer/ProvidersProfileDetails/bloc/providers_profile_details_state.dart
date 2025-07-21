part of 'providers_profile_details_bloc.dart';

@immutable
sealed class ProvidersProfileDetailsState {}

final class ProvidersProfileDetailsInitial
    extends ProvidersProfileDetailsState {}

final class CategorySelectedState extends ProvidersProfileDetailsState {}
