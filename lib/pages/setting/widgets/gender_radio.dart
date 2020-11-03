import 'package:flutter/material.dart';
import 'package:structure_flutter/core/common/enums/gender.dart';

class GenderRadio extends StatefulWidget {
  @override
  _GenderDropdown createState() => _GenderDropdown();
}

class _GenderDropdown extends State<GenderRadio> {
  String dropdownValue = 'VN';
  Gender _gender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: const Text('Male'),
              leading: Radio(
                value: Gender.Male,
                groupValue: _gender,
                onChanged: (Gender value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text('Female'),
              leading: Radio(
                value: Gender.Female,
                groupValue: _gender,
                onChanged: (Gender value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
