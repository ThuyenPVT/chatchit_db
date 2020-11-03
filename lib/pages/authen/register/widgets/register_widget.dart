import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/authen/login/login_screen.dart';
import 'package:structure_flutter/widgets/button_widget.dart';
import 'package:structure_flutter/widgets/form_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

class RegisterWidget extends StatefulWidget {
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String _imageURL;

  final _snackBar = getIt<SnackBarWidget>();

  final _registerBloc = getIt<RegisterBloc>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();


  @override
  void dispose() {
    _registerBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        _snackBar.buildContext = context;
        if (state.isFailure) {
          _snackBar.failure('Register failure !');
        }
        if (state.isSubmitting) {
          _snackBar.submitting('Register ...');
        }
        if (state.isSuccess) {
          _snackBar.success('Register successful !');
          Timer(Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
        }
      },
      child: BlocBuilder(
        cubit: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  FormWidget(
                    controller: _fullNameController,
                    hint: 'Enter your full name',
                    title: 'Full Name',
                    prefixIcon: AppIcons.account,
                    isValidForm: state.isFullNameValid,
                    validateMsg: 'Enter your valid full name',
                  ),
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
                  ButtonWidget(
                    onPressed: _onFormSubmitted,
                    text: 'REGISTER',
                    colors: AppColors.colors,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _onFormSubmitted() {
    _registerBloc.add(RegisterWithCredentials(
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imageURL: _imageURL,
    ));
  }
}
