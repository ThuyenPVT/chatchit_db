import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Let's get going!",
          style: AppStyles.black_18_FW700,
        ),
        Text(
          "Please enter your details.",
          style: AppStyles.black_18_FW200,
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
