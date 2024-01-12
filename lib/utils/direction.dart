import 'dart:math' as math;
import '../common/contents.dart';

Direction getRandowDirection({Direction? direction}) {
  int maxIndex = 4;

  final dirs = [Direction.up, Direction.down, Direction.left, Direction.right];
  if (direction != null) {
    dirs.remove(direction);
    maxIndex--;
  }
  final index = math.Random().nextInt(maxIndex);

  return dirs[index];
}
