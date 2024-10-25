import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeHelper {
  // Function to show a date picker with a wheel and top-right confirm button
  static Future<DateTime?> pickDate(BuildContext context, {required DateTime initialDate}) async {
    DateTime? pickedDate = initialDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return _buildPicker(
          context: context,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate,
            minimumDate: DateTime.now(), // Ensure no past dates
            onDateTimeChanged: (DateTime dateTime) {
              pickedDate = dateTime;
            },
          ),
        );
      },
    );

    return pickedDate;
  }

  // Function to show a time picker with a wheel and top-right confirm button
  static Future<TimeOfDay?> pickTime(BuildContext context, {required TimeOfDay initialTime}) async {
    TimeOfDay? pickedTime = initialTime;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return _buildPicker(
          context: context,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(), // Current time as the default
            onDateTimeChanged: (DateTime dateTime) {
              pickedTime = TimeOfDay.fromDateTime(dateTime);
            },
          ),
        );
      },
    );

    return pickedTime;
  }

  // Helper method to build the Cupertino picker with the confirm button
  static Widget _buildPicker({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Confirm', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Divider(height: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
