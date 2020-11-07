import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/assets_images.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/utils/media_utils.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/pages/authen/login/login_page.dart';
import 'package:structure_flutter/widgets/button_widget.dart';
import 'package:structure_flutter/widgets/form_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

import 'heading.dart';

class RegisterWidget extends StatefulWidget {
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  File _image;

  final _snackBar = getIt<SnackBarWidget>();

  final _registerBloc = getIt<RegisterBloc>();

  final _mediaUtil = getIt<MediaUtil>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();


  @override
  void dispose() {
    _registerBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _emailController.addListener(_onRegisterEmailChanged);
    _passwordController.addListener(_onRegisterPasswordChanged);
    _fullNameController.addListener(_onRegisterFullNameChanged);
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
          _snackBar.loading('Register ...');
        }
        if (state.isSuccess) {
          _snackBar.success('Register successful !');
          Timer(Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          });
        }
      },
      child: BlocBuilder(
        cubit: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Heading(),
                  _imageSelector(),
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

  Widget _imageSelector() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await _mediaUtil.getImageFromLibrary();
          setState(() {
            _image = _imageFile;
          });
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null
                  ? FileImage(_image)
                  : NetworkImage(AssetsImage.avatarDefault),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmitted() async {
    _registerBloc.add(RegisterWithCredentials(
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imageURL: _image,
    ));
  }

  void _onRegisterEmailChanged() {
    _registerBloc.add(RegisterEmailChanged(
      email: _emailController.text,
    ));
  }

  void _onRegisterPasswordChanged() {
    _registerBloc.add(RegisterPasswordChanged(
      password: _passwordController.text,
    ));
  }

  void _onRegisterFullNameChanged() {
    _registerBloc.add(RegisterFullNameChanged(
      fullName: _fullNameController.text,
    ));
  }
}
