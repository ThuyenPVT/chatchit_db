import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/assets_images.dart';
import '../../../core/resource/text_style.dart';

class Avatar extends StatelessWidget {
  final User user;

  Avatar(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(AssetsImage.avatar),
        ),
        Text(user.email, style: AppStyles.font_25),
      ],
    );
  }
}