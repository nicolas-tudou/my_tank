import 'dart:ui';

import 'package:flame/game.dart';

const double gap = 30;

class GameBoxArea {
  GameBoxArea(this.gameArea, this.operationArea, this.fireArea);

  final Rect gameArea;
  final Rect operationArea;
  final Rect fireArea;
}

GameBoxArea getGameArea(Vector2 screenSize) {
  double width;
  double height;
  double left;
  double top;
  if (screenSize.x > screenSize.y) {
    width = screenSize.y - gap;
    height = screenSize.y - gap;
    left = (screenSize.x - width) / 2;
    top = gap / 2;

    return GameBoxArea(
      Rect.fromLTWH(left, top, width, height),
      Rect.fromLTWH(gap, gap, (screenSize.x - width) / 2 - 2 * gap,
          screenSize.y - 2 * gap),
      Rect.fromLTWH(
        screenSize.x - (screenSize.x - width) / 2 + gap,
        gap,
        (screenSize.x - width) / 2 - 2 * gap,
        screenSize.y - 2 * gap,
      ),
    );
  } else {
    width = screenSize.x - gap;
    height = screenSize.x - gap;
    left = gap / 2;
    top = (screenSize.y - height) / 2;
    return GameBoxArea(
      Rect.fromLTWH(left, top, width, height),
      Rect.fromLTWH(
        gap / 2,
        screenSize.y - (screenSize.y - height) / 2,
        (screenSize.x) / 2 - gap / 2,
        (screenSize.y - height) / 2 - 10,
      ),
      Rect.fromLTWH(
        screenSize.x / 2 + gap / 2,
        screenSize.y - (screenSize.y - height) / 2,
        (screenSize.x) / 2 - gap,
        (screenSize.y - height) / 2 - 10,
      ),
    );
  }
}
