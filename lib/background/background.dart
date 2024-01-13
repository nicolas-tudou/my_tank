import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class TankBackground extends RectangleComponent with CollisionCallbacks {
  Rect area;

  TankBackground(this.area)
      : super(
          position: Vector2(area.left, area.top),
          size: Vector2(area.width, area.height),
          paint: Paint()
            ..color = const Color(0xffeeeeee)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );

  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return null;
  }
}
