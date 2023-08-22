import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jenoio/actors/food.dart';
import 'package:jenoio/actors/player.dart';
import 'package:jenoio/main.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<JenoIo>, CollisionCallbacks {
  final Random _random = Random();
  Vector2 velocity = Vector2.zero();

  Enemy() : super(size: Vector2.all(50));

  @override
  void onLoad() {
    add(
      CircleHitbox(),
    );
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 18,
        amountPerRow: 5,
        textureSize: Vector2.all(500),
        stepTime: .04,
      ),
    );
    // x = Random().nextDouble() * (player.x * 4);
    // y = Random().nextDouble() * (player.y * 4);
  }

  @override
  void update(double dt) {
    // Generate random movement direction
    if (_random.nextDouble() < 0.02) {
      velocity = Vector2(_random.nextDouble() * 100 - 50,
          _random.nextDouble() * 100 - 50 * dt);
    }

    // Apply velocity to the enemy's position
    position += velocity * dt;

    // Clamp enemy's position to stay within game bounds
    // Adjust these values according to your game's dimensions
    // position.x = position.x.clamp(0, gameRef.size.x);
    // position.y = position.y.clamp(0, gameRef.size.y);

    super.update(dt);
  }

  void grow() {
    size += Vector2.all(10.0);
  }

  void decline() {
    size -= Vector2.all(10.0);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Food) {
      grow();
      other.removeFromParent();
    } else if (other is Enemy || other is Player) {
      decline();
      if (size.x <= 0) {
        removeFromParent();
      }
    }
    super.onCollision(intersectionPoints, other);
  }
}
