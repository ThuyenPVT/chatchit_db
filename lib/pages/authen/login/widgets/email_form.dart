import 'package:flutter/material.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';

class EmailForm extends StatefulWidget {
  final bool _isValidEmail;
  final TextEditingController _emailController;

  EmailForm(this._isValidEmail, this._emailController);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _loginBloc = getIt<LoginBloc>();

  TextEditingController get _emailController => widget._emailController;

  bool get _isValidEmail => widget._isValidEmail;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _loginBloc.close();
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(
      email: _emailController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Text('Email', style: AppStyles.black38_16),
        ),
        TextFormField(
          controller: _emailController,
          validator: (_input) =>
              _isValidEmail ? null : "Please enter a valid email",
          decoration: InputDecoration(
            prefixIcon: AppIcons.email,
            hintText: 'Enter your email',
          ),
        ),
      ],
    );
  }
}
