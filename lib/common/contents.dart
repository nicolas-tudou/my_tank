import 'dart:ui';

import 'package:flutter/services.dart';

const gameBgColor = Color(0xff969696);

const maxLifeNumber = 3;

const gameAreaWidth = 420.0;

const tankSize = 30.0;

const enmyTankLimit = 3;

const homeSize = 84.0;

enum Direction {
  left,
  right,
  up,
  down,
}

const upKeys = [
  PhysicalKeyboardKey.keyW,
  PhysicalKeyboardKey.arrowUp,
];
const downKeys = [
  PhysicalKeyboardKey.keyS,
  PhysicalKeyboardKey.arrowDown,
];
const leftKeys = [
  PhysicalKeyboardKey.keyA,
  PhysicalKeyboardKey.arrowLeft,
];
const rightKeys = [
  PhysicalKeyboardKey.keyD,
  PhysicalKeyboardKey.arrowRight,
];

const moveKeys = [...upKeys, ...downKeys, ...leftKeys, ...rightKeys];
