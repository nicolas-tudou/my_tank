import 'package:flutter/material.dart';
import 'package:my_tank/pages/game.dart';

class GameModel extends ChangeNotifier {
  late MyTankGame _game;

  MyTankGame get gameRef => _game;

  setGame(MyTankGame gameInstance) {
    _game = gameInstance;
  }
}
