import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class OpBar extends CircleComponent {
  OpBar({super.position, super.radius})
      : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = Color.fromARGB(255, 35, 83, 160).withAlpha(100),
        );
  late CircleComponent bar;
  @override
  Future<void> onLoad() {
    super.onLoad();
    bar = CircleComponent(
      position: Vector2.all(radius),
      radius: 18,
      anchor: Anchor.center,
      paint: Paint()..color = const Color.fromARGB(255, 114, 16, 189),
      priority: 3,
    );
    add(bar);
    return Future(() => null);
  }

  void updateBarPosition(Vector2 delta) {
    if (delta.toOffset().distance > radius) {
      bar.position = Vector2.all(radius) + delta.normalized() * radius;
    } else {
      bar.position = Vector2.all(radius) + delta;
    }
  }
}
