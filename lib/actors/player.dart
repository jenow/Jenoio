import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jenoio/actors/enemy.dart';
import 'package:jenoio/actors/food.dart';
import 'package:jenoio/flame_layer/jenoio_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<JenoioGame>, CollisionCallbacks {
  static Vector2 initialSize = Vector2.all(50.0);
  Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;

  bool _move = false;
  double _targetX = 0;
  double _targetY = 0;
  double tolerance = 2.0;

  Player() : super(size: initialSize, anchor: Anchor.center);

  @override
  void onLoad() {
    add(
      CircleHitbox(),
    );
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('player2.png'),
      SpriteAnimationData.sequenced(
        amount: 60,
        amountPerRow: 5,
        textureSize: Vector2.all(480),
        stepTime: .04,
      ),
    );
    x = game.size.x / 2;
    y = game.size.y / 2;
  }

  @override
  void update(double dt) {
    // Move to the tapped position
    if (_move) {
      velocity = Vector2(
            _targetX - x,
            _targetY - y,
          ).normalized() *
          moveSpeed;
      _move = false;
    }

    // Stop once tapped position is reached
    if ((x - _targetX).abs() <= tolerance) {
      velocity.x = 0;
      x = _targetX;
    }
    if ((y - _targetY).abs() <= tolerance) {
      velocity.y = 0;
      y = _targetY;
    }

    position += velocity * dt;
    super.update(dt);
  }

  void moveTo(double x, double y) {
    _targetX = x;
    _targetY = y;
    _move = true;
  }

  void grow() {
    size += Vector2.all(10.0);

    double zoom = game.camera.zoom * .99;
    game.camera.zoom = zoom;
  }

  void decline() {
    size -= Vector2.all(10.0);

    double zoom = game.camera.zoom * 1.01;
    game.camera.zoom = zoom;
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
