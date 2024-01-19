import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:my_tank/pages/game.dart';

import '../common/contents.dart';
import '../utils/math.dart';
import 'op_bar.dart';

class DirectionOperation extends RectangleComponent
    with HasGameRef<MyTankGame>, DragCallbacks {
  DirectionOperation({super.position, super.size}) {
    paint = Paint()
      ..color = const Color(0xffffffff)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  Vector2? _startPoint;
  Vector2? _lastPoint;
  OpBar? opBar;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    final pos = event.localPosition;
    print('position: ${pos}');
    _startPoint = pos.clone();
    add(opBar = OpBar(position: pos, radius: 48));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final delta = event.localStartPosition - (_lastPoint ?? Vector2.zero());
    _lastPoint = event.localStartPosition;
    opBar!.updateBarPosition(
        event.localStartPosition - (_startPoint ?? Vector2.zero()));

    if (abs(delta.x) > abs(delta.y)) {
      // ver
      gameRef.myTank.autoMoveTo(delta.x > 0 ? Direction.right : Direction.left);
    } else if (abs(delta.x) < abs(delta.y)) {
      // hor
      gameRef.myTank.autoMoveTo(delta.y > 0 ? Direction.down : Direction.up);
    }
    return super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _startPoint = null;
    gameRef.myTank.stop();
    if (opBar != null) {
      opBar!.removeFromParent();
    }
    return super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    _startPoint = null;
    gameRef.myTank.stop();
    if (opBar != null) {
      opBar!.removeFromParent();
    }
    return super.onDragCancel(event);
  }
}
