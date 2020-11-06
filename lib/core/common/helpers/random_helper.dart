import 'dart:math';
import 'package:injectable/injectable.dart';

@singleton
class RandomHelper {
  Random random;

  RandomHelper(this.random);

  bool colors() => random.nextBool();

  int followers() => random.nextInt(1500);

  int feed() => random.nextInt(100);
}
