import 'dart:math';

import 'package:injectable/injectable.dart';

@singleton
class RandomHelper {
  Random random;

  RandomHelper(this.random);

  bool randomColors() => random.nextBool();

  int randomFollowers() => random.nextInt(1500);

  int randomFeed() => random.nextInt(100);
}
