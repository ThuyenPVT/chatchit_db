import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';

@singleton
class SnackBarWidget {
  BuildContext _buildContext;

  set buildContext(BuildContext _context) {
    _buildContext = _context;
  }

  void submitting(String _message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_message),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
  }

  void failure(String _message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('$_message'), Icon(Icons.error)],
          ),
          backgroundColor: Colors.red,
        ),
      );
  }

  void success(String _message) {
    Scaffold.of(_buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('$_message'), Icon(Icons.insert_emoticon)],
          ),
          backgroundColor: AppColors.greenColor,
        ),
      );
  }
}
