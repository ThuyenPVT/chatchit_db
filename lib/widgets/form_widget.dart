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
  Icon get _prefixIcon => widget.prefixIcon;

  bool get _isDisplayText => widget.isDisplayText;

  bool _isObscureText = false;

  IconData get _suffixIcon => widget.suffixIcon;

  String get _hint => widget.hint;

  String get _title => widget.title;

  bool get _isValidForm => widget.isValidForm;

  String get _validateMessage => widget.validateMsg;

  TextEditingController get _formController => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topLeft,
          child: Text(_title, style: AppStyles.black38_16),
        ),
        TextFormField(
          autocorrect: true,
          validator: (_input) => _isValidForm ? null : _validateMessage,
          controller: _formController,
          obscureText: _isObscureText,
          decoration: InputDecoration(
            prefixIcon: _prefixIcon,
            hintText: _hint,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => this._isObscureText = !this._isObscureText);
              },
              icon: _isDisplayText
                  ? Icon(_suffixIcon,
                      color: _isObscureText ? Colors.blueGrey : Colors.blue)
                  : Container(),
            ),
          ),
        )
      ],
    );
  }
}
