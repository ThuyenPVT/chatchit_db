import 'dart:math';

class RandomHelper {
  final Random random;

  RandomHelper(this.random);

  bool colors() => random.nextBool();

  int followers() => random.nextInt(1500);

  int feed() => random.nextInt(100);
}
