import 'package:flutter/material.dart';

class LakeCalenderWidget extends StatelessWidget {
  final Map json;

  const LakeCalenderWidget({
    Key key,
    this.json,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      color: Colors.grey.withOpacity(0.1),
      child: CalendarDatePicker(
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
        currentDate: DateTime.now(),
        initialDate: DateTime.now(),
        onDateChanged: (value) {
          debugPrint('new datetime: $value');
        },
      ),
    );
  }
}
