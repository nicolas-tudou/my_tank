import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../game/game.dart';

class Wall extends SpriteComponent
    with HasGameRef<MyTankGame>, CollisionCallbacks {
  Wall({
    required super.sprite,
    super.size,
    required super.position,
  }) : super(
          anchor: Anchor.center,
        );

}

class WallManager {
  List<Wall> walls = [];
}
