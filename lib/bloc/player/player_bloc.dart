import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<PlayerEventSizeChanges>((event, emit) {
      emit.call(PlayerSizeChanged(event.size));
    });
  }
}
