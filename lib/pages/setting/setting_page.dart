import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/avatar.dart';
import 'widgets/birthday_date_picker.dart';
import 'widgets/gender_radio.dart';
import 'widgets/language_dropdown.dart';

class SettingPage extends StatefulWidget {
  final User user;

  SettingPage(this.user);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingPage> {
  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar(user),
        Container(
          margin: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Text('SETTING'),
        ),
        LanguageDropdown(),
        GenderRadio(),
        BirthdayDatePicker(),
      ],
    );
  }
}
