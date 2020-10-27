import 'package:flutter/material.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/pages/authen/register/widgets/signup_button.dart';

import 'google_login_button.dart';
import 'login_button.dart';

class LoginGroupButton extends StatefulWidget {
  final LoginBloc _loginBloc;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  LoginGroupButton(
    this._emailController,
    this._passwordController,
    this._loginBloc,
  );

  @override
  _LoginButtonsState createState() => _LoginButtonsState();
}

class _LoginButtonsState extends State<LoginGroupButton> {
  LoginBloc get _loginBloc => widget._loginBloc;

  TextEditingController get _emailController => widget._emailController;

  TextEditingController get _passwordController => widget._passwordController;

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LoginButton(onPressed: () => _onFormSubmitted()),
          GoogleLoginButton(),
          CreateAccountButton(),
        ],
      ),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentials(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}
