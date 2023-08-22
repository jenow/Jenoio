import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jenoio/flame_layer/jenoio_game.dart';

class Food extends SpriteAnimationComponent with HasGameRef<JenoioGame> {
  static Vector2 maxSize = Vector2.all(30.0);
  static final Random random = Random();
  Vector2? pos;

  Food({this.pos}) : super(size: maxSize);

  @override
  void onLoad() {
    add(
      CircleHitbox(),
    );
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('food2.png'),
      SpriteAnimationData.sequenced(
        amount: 13,
        amountPerRow: 5,
        textureSize: Vector2.all(320),
        stepTime: .05,
      ),
    );
    anchor = Anchor.center;
    if (pos != null) {
      position = pos!;
    } else {
      x = random.nextDouble() * (game.size.x * 4);
      y = random.nextDouble() * (game.size.y * 4);
    }
    size = maxSize * (random.nextDouble() * .8 + .3);
  }
}