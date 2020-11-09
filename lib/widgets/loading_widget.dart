import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading ...',
            style: AppStyles.black38_16,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
