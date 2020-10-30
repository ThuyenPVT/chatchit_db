import 'package:flutter/material.dart';
import '../../../../core/resource/text_style.dart';

class CheckBoxForm extends StatefulWidget {
  final VoidCallback _onChecked;

  CheckBoxForm({Key key, VoidCallback onChecked})
      : _onChecked = onChecked,
        super(key: key);

  @override
  _CheckBoxFormState createState() => _CheckBoxFormState();
}

class _CheckBoxFormState extends State<CheckBoxForm> {
  VoidCallback get _onChecked => widget._onChecked;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              if (isChecked) {
                return _onChecked;
              }
            },
          ),
          Text(
            'Remember',
            style: AppStyles.black_12,
          )
        ],
      ),
    );
  }
}
