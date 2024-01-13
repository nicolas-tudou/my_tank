import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';


class MyTankHome extends RectangleComponent with CollisionCallbacks {
  MyTankHome({super.position, super.size, required this.homeSprite})
      : super(paint: BasicPalette.transparent.paint());

  Sprite homeSprite;

  late SpriteComponent com;

  @override
  Future<void>? onLoad() {
    add(com = SpriteComponent(
      sprite: homeSprite,
      size: Vector2.all(36),
      position: Vector2.zero(),
    ));
    add(RectangleHitbox());
    return null;
  }

}
