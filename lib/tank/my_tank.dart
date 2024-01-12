import 'package:flame/components.dart';
import 'package:my_tank/tank/bullet.dart';
import '../common/contents.dart';
import 'base_tank.dart';

class MyTank extends BaseTank {
  MyTank(Sprite sprite, Vector2 position)
      : super(sprite: sprite, position: position);

  bool moving = false;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet && !other.isMine) {
      print('my tank die !!!');
    }
    stop();
  }

  @override
  void update(double dt) {
    if (moving) {
      move();
    }
    super.update(dt);
  }

  @override
  void move() {
    var pos = nextPosition();
    var dir = overflowDirection(pos);
    if (dir == null) {
      position = pos;
    }
  }

  void start() {
    moving = true;
  }

  void stop() {
    moving = false;
  }
}
