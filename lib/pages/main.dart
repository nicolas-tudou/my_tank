import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/fire_bar.dart';
import '../components/game_info.dart';
import '../components/operation_bar.dart';
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
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('game info'),
                  ),
                ),
                OperationBar(),
              ],
            ),
          ),
          Expanded(flex: 3, child: buildGameContent()),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('game info'),
                  ),
                ),
                FireBar(),
                SizedBox(height: 30),
              ],
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
            child: GameInfo(),
          ),
          Expanded(flex: 3, child: buildGameContent()),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OperationBar(),
                  FireBar(),
                ],
              )),
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
