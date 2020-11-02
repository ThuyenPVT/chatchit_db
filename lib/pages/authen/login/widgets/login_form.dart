import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/widgets/button_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

import 'file:///G:/Project/chatchit_project/Structure_Flutter/lib/pages/authen/login/widgets/signup_button.dart';

import '../../../../bloc/bloc.dart';
import '../../../../widgets/form_widget.dart';
import 'checkbox_form.dart';

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
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordController.dispose();
    _emailController.dispose();
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
          _snackBar.loading('Logging in...');
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
                  FormWidget(
                    controller: _emailController,
                    hint: 'Enter your email',
                    title: 'Email',
                    prefixIcon: AppIcons.email,
                    isValidForm: state.isEmailValid,
                    validateMsg: 'Enter your valid email',
                  ),
                  FormWidget(
                    controller: _passwordController,
                    hint: 'Enter your password',
                    title: 'Password',
                    prefixIcon: AppIcons.security,
                    isValidForm: state.isPasswordValid,
                    validateMsg: 'Enter your valid password',
                    isDisplayText: true,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  CheckBoxForm(),
                  ButtonWidget(
                    onPressed: _onFormSubmitted,
                    text: 'LOGIN',
                    colors: AppColors.colors,
                  ),
                  ButtonWidget(
                    onPressed: _onGoogleFormSubmitted,
                    text: 'LOGIN WITH GOOGLE ACCOUNT',
                    colors: AppColors.googleColors,
                    icon: AppIcons.google,
                  ),
                  SignUpButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentials(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _onGoogleFormSubmitted() {
    _loginBloc.add(LoginWithGoogle());
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(
      email: _emailController.text,
    ));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(
      password: _passwordController.text,
    ));
  }
}
