import 'package:flutter/material.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class GoogleLoginButton extends StatelessWidget {
  final _loginBloc = getIt<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      icon: Icon(
        FontAwesomeIcons.google,
        color: AppColors.white,
      ),
      onPressed: () {
        _loginBloc.add(LoginWithGoogle());
      },
      label: Text('Sign in with Google', style: AppStyles.white_16),
      color: AppColors.red,
    );
  }
}
