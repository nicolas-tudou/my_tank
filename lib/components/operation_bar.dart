import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../common/contents.dart';
import '../pages/main.dart';

const double boxWidth = 130;
const double barWidth = 36;
Offset boxSize = const Offset(boxWidth, boxWidth);
Offset barSize = const Offset(barWidth, barWidth);
Offset defaultPosition = (boxSize - barSize) / 2;

class OperationBar extends StatefulWidget {
  const OperationBar({super.key});

  @override
  State<OperationBar> createState() => _OperationBarState();
}

class _OperationBarState extends State<OperationBar> {
  Offset position = defaultPosition;
  Direction direction = Direction.up;

  void _handlePanDown(DragDownDetails detail) {
    // print(detail.localPosition);
    setState(() {
      position = detail.localPosition - barSize / 2;
    });
  }

  void _handlePanUpdate(DragUpdateDetails detail) {
    // print('delta:${detail.delta}');
    Offset newPos = position + detail.delta;
    Offset gap = newPos - defaultPosition;
    double maxR = boxSize.dx / 2 - barSize.dx / 2;
    // print('maxR: ${maxR}');
    if (math.sqrt(gap.dx * gap.dx + gap.dy * gap.dy) > maxR) {
      return;
    }

    var relatePos = newPos - (boxSize - barSize) / 2;
    if (relatePos.direction > -math.pi / 4 &&
        relatePos.direction < math.pi / 4) {
      direction = Direction.right;
    } else if (relatePos.direction > math.pi / 4 &&
        relatePos.direction < math.pi * 3 / 4) {
      direction = Direction.down;
    } else if (relatePos.direction > math.pi * 3 / 4 ||
        relatePos.direction < -math.pi * 3 / 4) {
      direction = Direction.left;
    } else {
      direction = Direction.up;
    }

    myTankGameInstance.myTank.autoMoveTo(direction);

    setState(() {
      position = newPos;
    });
  }

  void _handlePanEnd(DragEndDetails detail) {
    // print(detail.velocity.pixelsPerSecond);
    myTankGameInstance.myTank.stop();
    setState(() {
      position = defaultPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _handlePanDown,
      onPanEnd: _handlePanEnd,
      onPanUpdate: _handlePanUpdate,
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        child: Stack(
          children: [
            Container(
              width: boxSize.dx,
              height: boxSize.dy,
              padding: EdgeInsets.all(barSize.dx / 2),
              child: const OperationBackground(),
            ),
            Positioned(
              top: position.dy,
              left: position.dx,
              child: const OperationIndicatorBar(),
            ),
            Positioned(
              top: 20,
              left: 50,
              child: OperationDirectionIndicator(
                active: direction == Direction.up,
                direction: direction,
              ),
            ),
            Positioned(
              top: 50,
              left: 80,
              child: OperationDirectionIndicator(
                active: direction == Direction.right,
                direction: direction,
              ),
            ),
            Positioned(
              top: 80,
              left: 50,
              child: OperationDirectionIndicator(
                active: direction == Direction.down,
                direction: direction,
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: OperationDirectionIndicator(
                active: direction == Direction.left,
                direction: direction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationDirectionIndicator extends StatelessWidget {
  OperationDirectionIndicator(
      {super.key, required bool active, required Direction direction});

  bool active = false;
  Direction? direction;

  @override
  Widget build(BuildContext context) {
    return Container(child: Icon(Icons.auto_graph));
  }
}

class DirectionArrow extends StatelessWidget {
  DirectionArrow({super.key, required Direction this.direction});

  Direction direction;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OperationBackground extends StatelessWidget {
  const OperationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          radius: 1,
          colors: [
            Color(0xff0caae4),
            Color(0xffe994b4),
          ],
        ),
      ),
    );
  }
}

class OperationIndicatorBar extends StatelessWidget {
  const OperationIndicatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: barSize.dx,
      height: barSize.dy,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withAlpha(100),
      ),
    );
  }
}
