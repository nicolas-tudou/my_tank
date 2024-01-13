import 'package:flame/components.dart';
import 'package:my_tank/common/contents.dart';
import 'package:my_tank/tank/bullet.dart';
import 'base_tank.dart';

class MyTank extends BaseTank {
  MyTank(Sprite sprite, Vector2 position)
      : super(sprite: sprite, position: position);

  bool autoMove = false;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet && !other.isMine) {
      // TODO handle this
      print('my tank die !!!');
    }
    stop();
  }

  @override
  void update(double dt) {
    if (autoMove) {
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

  void autoMoveTo(Direction dir) {
    autoMove = true;
    moveTo(dir);
  }

  void moveTo(Direction dir) {
    changeDirection(dir);
    move();
  }

  void start() {
    autoMove = true;
  }

  void stop() {
    autoMove = false;
  }
}
