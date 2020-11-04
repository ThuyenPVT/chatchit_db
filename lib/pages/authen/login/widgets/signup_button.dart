import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/pages/authen/register/register_page.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dont\'t have an account yet?',
        ),
        FlatButton(
          clipBehavior: Clip.none,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child: Text(
            'sign up',
            style: AppStyles.black38_14,
          ),
        ),
      ],
    );
  }
}
