import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: _onPressed,
      child: Text('login', style: AppStyles.black38_16),
    );
  }
}
