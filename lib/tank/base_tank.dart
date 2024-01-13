import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:my_tank/tank/bullet.dart';

import '../common/contents.dart';
import '../game/game.dart';
import '../utils/sprite.dart';

abstract class BaseTank extends SpriteComponent
    with HasGameRef<MyTankGame>, CollisionCallbacks {
  BaseTank({
    required super.sprite,
    super.size,
    required super.position,
    this.direction = Direction.up,
  }) : super(
          anchor: Anchor.center,
          angle: getAngleByDirection(direction),
        );

  double speed = 2;

  Direction direction = Direction.up;

  Bullet? bullet;

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return null;
  }

  @mustCallSuper
  void collosionCb(PositionComponent other) {
    bullet = null;
  }

  void move();

  void changeDirection(Direction dir) {
    direction = dir;
    angle = getAngleByDirection(dir);
  }

  Vector2 getBulletPosition() {
    final bs = Bullet.defaultSize;

    Vector2 offset = Vector2(-bs.x / 2, -size.y / 2);
    switch (direction) {
      case Direction.up:
        break;
      case Direction.down:
        offset = Vector2(-bs.x / 2, size.y / 2 - bs.y);
        break;
      case Direction.left:
        offset = Vector2(-size.x / 2, -bs.y / 2);
        break;
      case Direction.right:
        offset = Vector2(size.x / 2 - bs.x, -bs.y / 2);
        break;
    }

    return position + offset;
  }

  Vector2 nextPosition() {
    var pos = position.clone();
    switch (direction) {
      case Direction.up:
        pos = pos..y -= speed;
        break;
      case Direction.down:
        pos = pos..y += speed;
        break;
      case Direction.left:
        pos = pos..x -= speed;
        break;
      case Direction.right:
        pos = pos..x += speed;
        break;
    }
    var abPos = absolutePositionOf(pos);
    if (gameRef.canMoveTo(abPos)) {
      return pos;
    }
    return position;
  }

  Direction? overflowDirection(Vector2 nextPos) {
    if (gameRef.gameArea.left >= nextPos.x - size.x / 2) {
      // 左侧超出边界
      return Direction.left;
    }
    if (nextPos.y - size.y / 2 <= 0) {
      // 上方超出边界
      return Direction.up;
    }
    if (nextPos.x + size.x / 2 >
        gameRef.gameArea.left + gameRef.gameArea.width) {
      // 右侧超出边界
      return Direction.right;
    }
    if (nextPos.y + size.y / 2 >
        gameRef.gameArea.top + gameRef.gameArea.height) {
      // 下方超出边界
      return Direction.down;
    }
    return null;
  }

  fire({bool isMine = false}) {
    if (bullet != null) return;
    gameRef.startFireAudio();
    gameRef.add(bullet = Bullet(
      Sprite(
        gameRef.spriteImage,
        srcPosition: getBulletSrcPosition(direction),
        srcSize: getBulletSrcSize(direction),
      ),
      getBulletPosition(),
      direction,
      collosionCb: collosionCb,
      isMine: isMine,
    ));
  }
}
