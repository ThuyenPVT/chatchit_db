import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';

@singleton
class SnackBarWidget {
  BuildContext _buildContext;

  set buildContext(BuildContext context) {
    _buildContext = context;
  }

  void loading(String message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
  }

  void failure(String message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('$message'), Icon(Icons.error)],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  void success(String message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('$message'), Icon(Icons.insert_emoticon)],
          ),
          backgroundColor: AppColors.greenColor,
        ),
      );
  }
}
