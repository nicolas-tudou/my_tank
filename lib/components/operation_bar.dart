import 'dart:math' as math;
import 'package:flutter/material.dart';

class OperationBar extends StatefulWidget {
  const OperationBar({super.key});

  @override
  State<OperationBar> createState() => _OperationBarState();
}

Offset boxSize = const Offset(130, 130);
Offset barSize = const Offset(30, 30);
Offset defaultPosition = (boxSize - barSize) / 2;

class _OperationBarState extends State<OperationBar> {
  Offset position = defaultPosition;

  void _handlePanDown(DragDownDetails detail) {
    // print(detail.localPosition);
    setState(() {
      position = detail.localPosition - barSize / 2;
    });
  }

  void _handlePanStart(DragStartDetails detail) {
    // print(detail.localPosition);
    // setState(() {
    //   position = detail.localPosition - barSize / 2;
    // });
  }

  void _handlePanUpdate(DragUpdateDetails detail) {
    print('delta:${detail.delta}');
    Offset newPos = position + detail.delta;
    Offset gap = newPos - defaultPosition;
    double maxR = boxSize.dx / 2 - barSize.dx / 2;
    print('maxR: ${maxR}');
    if (math.sqrt(gap.dx * gap.dx + gap.dy * gap.dy) > maxR) {
      return;
    }
    setState(() {
      position = newPos;
    });
  }

  void _handlePanEnd(DragEndDetails detail) {
    // print(detail.velocity.pixelsPerSecond);
    setState(() {
      position = defaultPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('position: ${position}');
    return GestureDetector(
      onPanDown: _handlePanDown,
      onPanStart: _handlePanStart,
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
          ],
        ),
      ),
    );
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
