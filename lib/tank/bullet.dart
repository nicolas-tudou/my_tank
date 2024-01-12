import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:my_tank/tank/enmy_tank.dart';
import 'package:my_tank/tank/my_tank.dart';

import '../background/background.dart';
import '../common/contents.dart';
import '../game/game.dart';
import '../types/collision.dart';

class Bullet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyTankGame> {
  static Vector2 defaultSize = Vector2(10, 16);

  Bullet(Sprite sprite, Vector2 position, this.direction,
      {Vector2? size, this.isMine = false, this.collosionCb})
      : super(sprite: sprite, position: position, size: size);

  bool isMine = false;

  Direction direction = Direction.up;

  double speed = 5;

  CollisionCBFunction? collosionCb;

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    switch (direction) {
      case Direction.up:
        position = position..y -= speed;
        break;
      case Direction.down:
        position = position..y += speed;
        break;
      case Direction.left:
        position = position..x -= speed;
        break;
      case Direction.right:
        position = position..x += speed;
        break;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // print('bullet coll, $isMine, $other');
    gameRef.startHitAudio();
    if (other is TankBackground) {}
    if (collosionCb != null) {
      collosionCb!(other);
    }
    if (!((other is MyTank && isMine) || (other is EnmyTank && !isMine))) {
      // print('bullet coll, remove');
      removeFromParent();
    }
    // FlameAudio.play('hit.wav');
  }
}
