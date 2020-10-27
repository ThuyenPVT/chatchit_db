import 'package:flutter/material.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';

class PasswordForm extends StatefulWidget {
  final LoginState _state;
  final TextEditingController _passwordController;

  PasswordForm(this._state, this._passwordController);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _isObscureText = true;

  final _loginBloc = getIt<LoginBloc>();

  LoginState get _state => widget._state;

  TextEditingController get _passwordController => widget._passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _loginBloc.close();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Text('Password', style: AppStyles.black38_16),
        ),
        TextFormField(
          controller: _passwordController,
          autocorrect: false,
          autovalidate: true,
          obscureText: _isObscureText,
          validator: (_input) =>
              _state.isPasswordValid ? null : 'Please enter a valid password',
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.security),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => this._isObscureText = !this._isObscureText);
              },
              icon: Icon(Icons.remove_red_eye),
            ),
          ),
        ),
      ],
    );
  }
}
