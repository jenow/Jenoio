import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenoio/bloc/player/player_bloc.dart';
import 'package:jenoio/flame_layer/flame_layer.dart';
import 'package:jenoio/flutter_layer/flutter_layer.dart';

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(),
        ),
      ],
      child: const Stack(
        children: [
          FlameLayer(),
          FutterLayer(),
        ],
      ),
    ),
  );
}

