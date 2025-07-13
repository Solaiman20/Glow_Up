part of 'maps_bloc.dart';

@immutable
sealed class MapsState {}

final class MapsInitial extends MapsState {}

final class PositionDetermined extends MapsState {
  PositionDetermined();
}
