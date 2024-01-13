import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:my_tank/game/game.dart';

class FireOperation extends RectangleComponent
    with HasGameRef<MyTankGame>, TapCallbacks {
  FireOperation({super.position, super.size}) {
    paint = Paint()
      ..color = const Color(0xff000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  @override
  void onTapDown(TapDownEvent event) {
    print('fire~~');
    gameRef.myTank.fire(isMine: true);
  }
}
