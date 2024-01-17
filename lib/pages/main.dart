import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class GamgeWidget extends StatelessWidget {
  const GamgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      return _buildLandscapeScreen();
    } else {
      return _buildNormalScreen();
    }
  }

  Widget _buildLandscapeScreen() {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text('operation & score'),
            ),
          ),
          Expanded(flex: 3, child: buildGameContent()),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('fire & other info'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalScreen() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text('score info'),
            ),
          ),
          Expanded(flex: 3, child: buildGameContent()),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('operation'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameContent() {
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
