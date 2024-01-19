import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/fire_bar.dart';
import '../components/game_info.dart';
import '../components/operation_bar.dart';
import 'game.dart';

late MyTankGame myTankGameInstance;

class GamgeWidget extends StatelessWidget {
  const GamgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (size.width > size.height) {
      return _buildLandscapeScreen(context);
    } else {
      return _buildNormalScreen(context);
    }
  }

  Widget _buildLandscapeScreen(BuildContext context) {
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
          Expanded(flex: 3, child: buildGameContent(context)),
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

  Widget _buildNormalScreen(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GameInfo(),
          ),
          Expanded(flex: 3, child: buildGameContent(context)),
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

  Widget buildGameContent(BuildContext context) {
    var gameInstance = MyTankGame();
    myTankGameInstance = gameInstance;

    return GameWidget<MyTankGame>(
      game: gameInstance,
      overlayBuilderMap: const {
        // 'menu': (_, game) => Menu(game),
        // 'gameover': (_, game) => GameOver(game),
      },
      // initialActiveOverlays: const ['menu'],
    );
  }
}
