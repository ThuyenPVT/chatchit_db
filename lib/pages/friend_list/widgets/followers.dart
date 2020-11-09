import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class Followers extends StatelessWidget {
  final int randomFeed;

  final int randomFollowers;

  Followers(this.randomFeed, this.randomFollowers);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Feed',
              style: AppStyles.black26_10,
            ),
            Text(
              '$randomFeed',
              style: AppStyles.black,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Followers',
              style: AppStyles.black26_10,
            ),
            Text('$randomFollowers', style: AppStyles.black),
          ],
        ),
      ],
    );
  }
}
