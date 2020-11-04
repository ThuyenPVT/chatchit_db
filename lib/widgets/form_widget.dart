import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class FormWidget extends StatefulWidget {
  TextEditingController controller;
  String hint;
  String title;
  Icon prefixIcon;
  bool isValidForm;
  String validateMsg;
  bool isDisplayText;
  IconData suffixIcon;

  FormWidget({
    this.controller,
    this.hint,
    this.title,
    this.prefixIcon,
    this.isValidForm,
    this.validateMsg,
    this.isDisplayText = false,
    this.suffixIcon,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool _isObscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Text(widget.title, style: AppStyles.black38_16),
        ),
        TextFormField(
          autocorrect: true,
          validator: (_input) => widget.isValidForm ? null : widget.validateMsg,
          controller: widget.controller,
          obscureText: _isObscureText,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText: widget.hint,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => this._isObscureText = !this._isObscureText);
              },
              icon: widget.isDisplayText
                  ? Icon(widget.suffixIcon,
                      color: _isObscureText ? Colors.blueGrey : Colors.blue)
                  : Container(),
            ),
          ),
        )
      ],
    );
  }
}
