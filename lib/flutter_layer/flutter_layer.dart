import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenoio/bloc/player/player_bloc.dart';

class FutterLayer extends StatelessWidget {
  const FutterLayer({super.key});

  @override
  Widget build(BuildContext context) => BlocListener(
        listener: (context, state) {
          if (state is PlayerSizeChanged) {
            context.read<PlayerBloc>().add(PlayerEventSizeChanges(state.size));
          }
        },
        child: Container(),
      );
}
