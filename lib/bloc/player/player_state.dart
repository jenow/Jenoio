part of 'player_bloc.dart';

@immutable
sealed class PlayerState {}

class PlayerInitial extends PlayerState {
  final double size = 0;
}

class PlayerSizeChanged extends PlayerState {
  final double size;

  PlayerSizeChanged(this.size);
}