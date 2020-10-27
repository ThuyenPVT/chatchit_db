import 'package:structure_flutter/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/pages/authen/login/widgets/email_form.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';
import '../../../../bloc/bloc.dart';
import 'checkbox_form.dart';
import 'login_group_button.dart';
import 'password_form.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginBloc = getIt<LoginBloc>();
  final _snackBar = getIt<SnackBarWidget>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        _snackBar.buildContext = context;
        if (state.isFailure) {
          _snackBar.failure('Login failure !');
        }
        if (state.isSubmitting) {
          _snackBar.submitting('Login ...');
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder(
        cubit: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  EmailForm(state.isEmailValid, _emailController),
                  PasswordForm(state, _passwordController),
                  CheckBoxForm(),
                  LoginGroupButton(_emailController, _passwordController, _loginBloc),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
