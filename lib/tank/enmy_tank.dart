import 'dart:math' as math;
import 'package:flame/components.dart';
import '../tank/bullet.dart';
import '../utils/direction.dart';
import '../common/contents.dart';
import 'base_tank.dart';

class EnmyTank extends BaseTank {
  EnmyTank(Sprite sprite, Vector2 position)
      : super(sprite: sprite, position: position, direction: Direction.down);

  late Timer dirTimer = Timer(
    3,
    repeat: true,
    onTick: () {
      if (math.Random().nextDouble() < 0.5) {
        changeDirection(getRandowDirection(direction: direction));
      }
    },
    autoStart: true,
  );

  late Timer fireTimer = Timer(
    1,
    repeat: true,
    autoStart: true,
    onTick: () {
      fire();
    },
  );

  // @override
  // Future<void>? onLoad() {
  //   fire();
  // }

  @override
  void update(double dt) {
    move();
    dirTimer.update(dt);
    fireTimer.update(dt);
  }

  @override
  void move() {
    var pos = nextPosition();
    var dir = overflowDirection(pos);
    if (dir != null) {
      dirTimer.reset();
      changeDirection(getRandowDirection(direction: dir));
    } else {
      position = pos;
    }
  }

  @override
  void collosionCb(PositionComponent other) {
    super.collosionCb(other);
    fireTimer.resume();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet && other.isMine) {
      removeFromParent();
      gameRef.enmyTanks.remove(this);
      return;
    }
    changeDirection(getRandowDirection(direction: direction));
    super.onCollisionStart(intersectionPoints, other);
  }
}
