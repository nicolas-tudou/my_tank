import 'dart:ui';

import 'package:flame/components.dart';

import '../game/game.dart';
import 'sprite.dart';

Vector2 getEnmyTankRandomPosition(Rect area) {
  return Vector2(area.left + area.width / 2, 64);
}
