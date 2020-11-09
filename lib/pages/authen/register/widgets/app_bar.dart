import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/pages/authen/login/login_page.dart';

Widget appBar(BuildContext context) {
  return AppBar(
      title: Text(
        'Register',
        style: AppStyles.blue_18,
      ),
      elevation: 0,
      backgroundColor: AppColors.white_10,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        },
        icon: AppIcons.arrowBack,
        color: AppColors.blue,
      ));
}
