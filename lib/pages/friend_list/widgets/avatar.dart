import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/assets_images.dart';

class Avatar extends StatelessWidget {
  final String avatar;

  final bool randomColors;

  Avatar(this.avatar, this.randomColors);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Baseline(
        baseline: 35,
        baselineType: TextBaseline.ideographic,
        child: CircleAvatar(
          radius: 26,
          backgroundColor: randomColors ? Colors.red : Colors.blue,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: avatar != "null"
                ? NetworkImage(avatar)
                : NetworkImage(AssetsImage.avatarDefault),
          ),
        ),
      ),
    );
  }
}
