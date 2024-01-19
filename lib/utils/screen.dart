import 'dart:ui';

import 'package:flame/game.dart';

const double gap = 30;

Rect getGameArea(Vector2 screenSize) {
  double width;
  double height;
  double left;
  double top;
  if (screenSize.x > screenSize.y) {
    width = screenSize.y - gap;
    height = screenSize.y - gap;
    left = (screenSize.x - width) / 2;
    top = gap / 2;

    return Rect.fromLTWH(left, top, width, height);
  } else {
    width = screenSize.x - gap;
    height = screenSize.x - gap;
    left = gap / 2;
    top = (screenSize.y - height) / 2;
    return Rect.fromLTWH(left, top, width, height);
  }
}
