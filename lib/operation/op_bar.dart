import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class OpBar extends CircleComponent {
  OpBar({super.position, super.radius})
      : super(
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xffffffff).withAlpha(100),
        );
  late CircleComponent bar;
  @override
  Future<void>? onLoad() {
    bar = CircleComponent(
      position: Vector2.all(radius),
      radius: 24,
      anchor: Anchor.center,
      paint: Paint()..color = Color.fromARGB(255, 114, 16, 189),
      priority: 3,
    );
    add(bar);
  }

  void updateBarPosition(Vector2 delta) {
    if (delta.toOffset().distance > radius) {
      bar.position = Vector2.all(radius) + delta.normalized() * radius;
    } else {
      bar.position = Vector2.all(radius) + delta;
    }
  }
}
