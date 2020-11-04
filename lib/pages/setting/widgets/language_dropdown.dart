import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdown createState() => _LanguageDropdown();
}

class _LanguageDropdown extends State<LanguageDropdown> {
  String dropdownValue = 'VN';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text('Language', style: AppStyles.font_14),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['VN', 'US', 'JP', 'EN']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
