import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:my_tank/game/game.dart';

import '../common/contents.dart';
import '../utils/math.dart';
import 'op_bar.dart';

class DirectionOperation extends RectangleComponent
    with HasGameRef<MyTankGame>, Draggable {
  DirectionOperation({super.position, super.size}) {
    paint = Paint()
      ..color = const Color(0xffff4400)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  Vector2? _startPoint;
  OpBar? opBar;

  @override
  bool onDragStart(DragStartInfo info) {
    final pos = info.eventPosition.game;
    _startPoint = pos.clone();
    add(opBar = OpBar(position: pos, radius: 48));
    return super.onDragStart(info);
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    final delta = info.eventPosition.game - (_startPoint ?? Vector2.zero());
    opBar!.updateBarPosition(delta);

    if (abs(delta.x) > abs(delta.y)) {
      // ver
      gameRef.myTank
        ..changeDirection(delta.x > 0 ? Direction.right : Direction.left)
        ..move();
    } else if (abs(delta.x) < abs(delta.y)) {
      // hor
      gameRef.myTank
        ..changeDirection(delta.y > 0 ? Direction.down : Direction.up)
        ..move();
    }
    return super.onDragUpdate(info);
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    _startPoint = null;
    gameRef.myTank.stop();
    if (opBar != null) {
      opBar!.removeFromParent();
    }
    return super.onDragEnd(info);
  }

  @override
  bool onDragCancel() {
    _startPoint = null;
    gameRef.myTank.stop();
    if (opBar != null) {
      opBar!.removeFromParent();
    }
    return super.onDragCancel();
  }
}
