import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import '../home/home.dart';
import '../operation/direction_operation.dart';
import '../background/background.dart';
import '../common/contents.dart';
import '../operation/fire_operation.dart';
import '../tank/enmy_tank.dart';
import '../tank/my_tank.dart';
import '../utils/sprite.dart';

class MyTankGame extends FlameGame
    with HasCollisionDetection, HasTappables, HasDraggables {
  int score = 0;
  int lifeNumber = maxLifeNumber;
  int enmyTankNumber = 0;
  int destoryedTankNumber = 0;
  late final Image spriteImage;

  late Rect gameArea;

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
    gameArea = Rect.fromLTWH(
        (size.x - gameAreaWidth) / 2, 0, gameAreaWidth, size.y - 25);
    getPositionPool();
    spriteImage = await Flame.images.load('tank-img.png');
    // Flame.device.setPortraitUpOnly();
    Flame.device.setLandscapeRightOnly();
    // Flame.device.setOrientation(DeviceOrientation.landscapeRight);
    // Flame.device.setPortrait();
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
    gameArea = Rect.fromLTWH((canvasSize.x - gameAreaWidth) / 2, 0,
        gameAreaWidth, canvasSize.y - 25);
    getPositionPool();
    super.onGameResize(canvasSize);
  }

  void initAudio() async {
    // FlameAudio.bgm.initialize();
    // FlameAudio.bgm.play('start.wav');
    // await FlameAudio.audioCache.loadAll(['fire.wav', 'hit.wav']);
    firePool = await FlameAudio.createPool('fire.wav', maxPlayers: 7);
    hitPool = await FlameAudio.createPool('hit.wav', maxPlayers: 1);
  }

  void startFireAudio() {
    firePool.start();
  }

  void startHitAudio() {
    hitPool.start();
  }

  void getPositionPool() {
    positionPool = [
      Vector2(
        gameArea.left + tankSize,
        gameArea.top + tankSize / 2,
      ),
      Vector2(
        gameArea.left + gameArea.width / 2 + tankSize / 2,
        gameArea.top + tankSize / 2,
      ),
      Vector2(
        gameArea.left + gameArea.width - tankSize,
        gameArea.top + tankSize / 2,
      ),
    ];
  }

  _init() {
    loadBg();
    loadWall();
    loadOperation();
    loadHome();
    loadMyTank();
    loadEnmyTank();
    initTimer();
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
    const double gap = 8;
    add(dirOp = DirectionOperation(
      size: Vector2(gameArea.left - gap, size.y),
    ));
    add(FireOperation(
      position: Vector2(gameArea.left + gameArea.width + gap, 0),
      size: Vector2(size.x - gameArea.left - gameArea.width, size.y),
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
}
