import 'package:flutter/material.dart';
import '../../../core/resource/app_colors.dart';

class BirthdayDatePicker extends StatefulWidget {
  @override
  _ChoiceDatesState createState() => _ChoiceDatesState();
}

class _ChoiceDatesState extends State<BirthdayDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(11.0),
            alignment: Alignment.topLeft,
            child: Text(
              'CALENDAR',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
