part of 'player_bloc.dart';

@immutable
sealed class PlayerEvent {}

class PlayerEventSizeChanges extends PlayerEvent {
  final double size;

  PlayerEventSizeChanges(this.size);
}