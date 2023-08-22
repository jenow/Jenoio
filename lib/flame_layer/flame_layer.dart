import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jenoio/flame_layer/jenoio_game.dart';

class FlameLayer extends StatelessWidget {
  const FlameLayer({super.key});

  @override
  Widget build(BuildContext context) =>
      const GameWidget<JenoioGame>.controlled(gameFactory: JenoioGame.new);
}
