import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'app_colors.dart';

class AppIcons {
  //color icons
  static const arrowBack = Icon(Icons.arrow_back);
  static const camera = Icon(Icons.camera_enhance);
  static const dashboard = Icon(Icons.dashboard);
  static const security = Icon(Icons.security);

  static const google = Icon(FontAwesomeIcons.google, color: AppColors.white);

  static const email = Icon(Icons.email);
  static const account = Icon(Icons.account_circle);

  //Blue icons
  static const micro_blue = Icon(Icons.mic, color: AppColors.blue);
  static const send_blue = Icon(Icons.send, color: AppColors.blue);
  static const chat_blue = Icon(Icons.chat, color: Colors.blue);
  static const call_blue = Icon(Icons.call, color: Colors.blue);
  static const people_blue = Icon(Icons.notifications, color: Colors.blue);
  static const search_blue = Icon(Icons.search, color: Colors.blue);
  static const setting_blue = Icon(Icons.settings, color: Colors.blue);
  static const assignment_blue = Icon(Icons.assignment, color: Colors.blue);

  static const account_balance_wallet_blue = Icon(
    Icons.account_balance_wallet,
    color: Colors.blue,
  );
  static const emoticon_blue_25 = Icon(
    Icons.insert_emoticon,
    color: AppColors.blue,
    size: 25,
  );

  //Black icons
  static const arrowBack_black = Icon(Icons.arrow_back, color: Colors.black);
  static const arrowBackIos_black =
      Icon(Icons.arrow_back_ios, color: AppColors.black);
}
