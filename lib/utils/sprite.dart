import 'package:flame/game.dart';
import '../common/contents.dart';
import 'dart:math' as math;

Vector2 getTankSpriteSize() {
  return Vector2.all(tankSize);
}

Vector2 getHomeSpriteSize() {
  return Vector2(38, 30);
}

Vector2 getHomeSpritePosition() {
  return Vector2(581, 155);
}

Vector2 getBulletSrcPosition(Direction direction) {
  return Vector2(0, 152);
}

double getAngleByDirection(Direction direction) {
  switch (direction) {
    case Direction.up:
      return 0;
    case Direction.down:
      return math.pi;
    case Direction.left:
      return -math.pi / 2;
    case Direction.right:
      return math.pi / 2;
  }
}

Vector2 getBulletSrcSize(Direction? direction) {
  return Vector2(8, 8);
}
