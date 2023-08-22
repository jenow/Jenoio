import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:jenoio/actors/enemy.dart';
import 'package:jenoio/actors/food.dart';
import 'package:jenoio/actors/player.dart';

class JenoioGame extends FlameGame with TapDetector, HasCollisionDetection {
  final Player player = Player();
  List<Food> foodCells = [];

  void spawnFood() {
    final random = Random();
    final playerPosition = player.position;
    final maxX = playerPosition.x + camera.viewport.canvasSize!.x / 2;
    final maxY = playerPosition.y + camera.viewport.canvasSize!.y / 2;

    final food = Food(
        pos: Vector2(
      playerPosition.x + random.nextDouble() * maxX,
      playerPosition.y + random.nextDouble() * maxY,
    ));

    add(food);
  }

  void spawnEnemies(int count) {
    for (int i = 0; i < count; i++) {
      final enemy = Enemy();
      enemy.x = Random().nextDouble() * (player.x + 200);
      enemy.y = Random().nextDouble() * (player.y + 200);
      add(enemy);
    }
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'player2.png',
      'food2.png',
      'enemy.png',
    ]);

    for (int i = 0; i < 20; i++) {
      add(Food());
    }
    spawnEnemies(100);
    add(player);
    camera.followComponent(player);
  }

  @override
  void onTapDown(TapDownInfo info) {
    player.moveTo(info.eventPosition.game.x, info.eventPosition.game.y);
    for (int i = 0; i < 2; i++) {
      spawnFood();
    }
    spawnEnemies(2);
  }
}
