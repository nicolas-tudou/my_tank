import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' show KeyEventResult;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:my_tank/utils/screen.dart';
import '../home/home.dart';
import '../operation/direction_operation.dart';
import '../background/background.dart';
import '../common/contents.dart';
import '../operation/fire_operation.dart';
import '../tank/enmy_tank.dart';
import '../tank/my_tank.dart';
import '../utils/sprite.dart';

class MyTankGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  int score = 0;
  int lifeNumber = maxLifeNumber;
  int enmyTankNumber = 0;
  int destoryedTankNumber = 0;
  late final Image spriteImage;

  late Rect gameArea;
  late Rect operationArea;
  late Rect fireArea;

  late TankBackground bg;

  late MyTank myTank;
  List<EnmyTank> enmyTanks = [];
  late DirectionOperation dirOp;
  List<Vector2> positionPool = [];

  late Timer enmyTimer;

  late AudioPool firePool;
  late AudioPool hitPool;

  @override
  Color backgroundColor() => gameBgColor;

  @override
  Future<void>? onLoad() async {
    // Flame.device.setLandscape();
    // Flame.device.setLandscapeRightOnly();
    updateAreaInfo(size);
    spriteImage = await Flame.images.load('tank-img.png');
    add(ScreenHitbox());
    _init();
    initAudio();
  }

  @override
  void update(double dt) {
    enmyTimer.update(dt);
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    // print('game resize, $canvasSize');
    updateAreaInfo(canvasSize);
    getPositionPool();
    super.onGameResize(canvasSize);
  }

  void updateAreaInfo(Vector2 size) {
    var areaInfo = getGameArea(size);
    gameArea = areaInfo.gameArea;
    operationArea = areaInfo.operationArea;
    fireArea = areaInfo.fireArea;
  }

  void initAudio() async {
    // FlameAudio.bgm.initialize();
    // FlameAudio.bgm.play('start.wav');
    // await FlameAudio.audioCache.loadAll(['fire.wav', 'hit.wav']);
    firePool = await FlameAudio.createPool('fire.wav', maxPlayers: 7);
    hitPool = await FlameAudio.createPool('hit.wav', maxPlayers: 1);
  }

  void startFireAudio() {
    // firePool.start(); // TODO:
  }

  void startHitAudio() {
    // hitPool.start(); // TODO:
  }

  void getPositionPool() {
    positionPool = [
      Vector2(
        gameArea.left + tankSize,
        gameArea.top + tankSize,
      ),
      Vector2(
        gameArea.left + gameArea.width / 2 + tankSize / 2,
        gameArea.top + tankSize,
      ),
      Vector2(
        gameArea.left + gameArea.width - tankSize,
        gameArea.top + tankSize,
      ),
    ];
  }

  _init() {
    loadBg();
    loadWall();
    // loadOperation();
    loadHome();
    loadMyTank();
    loadEnmyTank();
    initTimer();
  }

  bool canMoveTo(Vector2 aim) {
    //
    return true;
  }

  initTimer() {
    enmyTimer = Timer(
      5,
      onTick: () {
        if (enmyTanks.length < enmyTankLimit) {
          loadEnmyTank();
        }
      },
      repeat: true,
      autoStart: true,
    );
  }

  _getHomePosition() {
    final spSize = getHomeSpriteSize();
    return Vector2(
      gameArea.left + gameArea.width / 2 - spSize.x / 2,
      gameArea.height + gameArea.top - spSize.y,
    );
  }

  _getMyTankPosition() {
    final size = getTankSpriteSize();
    return _getHomePosition() + Vector2(-size.x / 2 - 8, size.y / 2 - 3);
  }

  start() {}

  pause() {}

  reset() {
    score = 0;
    lifeNumber = maxLifeNumber;
    enmyTankNumber = 0;
    destoryedTankNumber = 0;
  }

  loadBg() {
    add(bg = TankBackground(gameArea));
  }

  loadOperation() {
    add(dirOp = DirectionOperation(
      position: Vector2(operationArea.left, operationArea.top),
      size: Vector2(operationArea.width, operationArea.height),
    ));
    add(FireOperation(
      position: Vector2(fireArea.left, fireArea.top),
      size: Vector2(fireArea.width, fireArea.height),
    ));
  }

  loadWall() {}

  loadHome() {
    add(MyTankHome(
      homeSprite: Sprite(
        spriteImage,
        srcPosition: getHomeSpritePosition(),
        srcSize: getHomeSpriteSize(),
      ),
      position: _getHomePosition(),
      size: getHomeSpriteSize(),
    ));
  }

  loadMyTank() {
    add(myTank = MyTank(
      Sprite(
        spriteImage,
        srcSize: getTankSpriteSize(),
      ),
      _getMyTankPosition(),
    ));
  }

  loadEnmyTank() {
    final tank = EnmyTank(
      Sprite(
        spriteImage,
        srcPosition: Vector2(0, tankSize),
        srcSize: getTankSpriteSize(),
      ),
      positionPool[math.Random().nextInt(positionPool.length)],
      // getEnmyTankRandomPosition(gameArea),
    );
    enmyTanks.add(tank);
    add(tank);
  }

  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyUpEvent) {
      if (moveKeys.contains(event.physicalKey)) {
        print('up');
        myTank.stop();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    print('down');
    if (event.physicalKey == PhysicalKeyboardKey.space) {
      print('space');
      myTank.fire(isMine: true);
      return KeyEventResult.handled;
    }

    if (leftKeys.contains(event.physicalKey)) {
      myTank.autoMoveTo(Direction.left);
      print('left');
      return KeyEventResult.handled;
    }
    if (upKeys.contains(event.physicalKey)) {
      print('up');
      myTank.autoMoveTo(Direction.up);
      return KeyEventResult.handled;
    }
    if (downKeys.contains(event.physicalKey)) {
      print('down');
      myTank.autoMoveTo(Direction.down);
      return KeyEventResult.handled;
    }
    if (rightKeys.contains(event.physicalKey)) {
      print('right');
      myTank.autoMoveTo(Direction.right);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
