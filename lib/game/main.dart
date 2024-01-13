import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class GamgeWidget extends StatelessWidget {
  const GamgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget<MyTankGame>(
      game: MyTankGame(),
      overlayBuilderMap: const {
        // 'menu': (_, game) => Menu(game),
        // 'gameover': (_, game) => GameOver(game),
      },
      // initialActiveOverlays: const ['menu'],
    );
  }
}
