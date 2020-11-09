import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/assets_images.dart';

import '../../../core/resource/text_style.dart';

class Avatar extends StatelessWidget {
  final String email;

  Avatar(this.email);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.double_spanish_white,
          backgroundImage: NetworkImage(AssetsImage.avatar),
        ),
        Text(email, style: AppStyles.font_25),
      ],
    );
  }
}
