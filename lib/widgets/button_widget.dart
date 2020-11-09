import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class ButtonWidget extends StatelessWidget {
  VoidCallback _onPressed;
  String text;
  List<Color> colors;
  Icon icon;

  ButtonWidget({
    Key key,
    VoidCallback onPressed,
    String text,
    List<Color> colors,
    Icon icon,
  })  : _onPressed = onPressed,
        text = text,
        colors = colors,
        icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: LinearGradient(colors: colors),
        color: AppColors.lightBlueAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: icon,
          ),
          FlatButton(
            onPressed:_onPressed,
            child: Text(
              text,
              style: AppStyles.white_bold_11,
            ),
          ),
        ],
      ),
    );
  }
}
