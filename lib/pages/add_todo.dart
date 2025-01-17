import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String, DateTime, DateTime) onSave;

  AddTodoDialog({required this.onSave});

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  // Function to show Cupertino-style date and time pickers with confirm buttons
  Future<void> _pickDateAndTime(BuildContext context, bool isStartTime) async {
    DateTime initialDate = DateTime.now(); // Current time as initial date

    // Ensure the minimum date is at least the current time
    DateTime? pickedDate = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        DateTime tempPickedDate = initialDate;
        return _buildBottomPicker(
          context,
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate,
            minimumDate: initialDate,  // Set minimum date to the current time
            onDateTimeChanged: (DateTime dateTime) {
              tempPickedDate = dateTime;
            },
          ),
          onConfirm: () {
            Navigator.pop(context, tempPickedDate);
          },
        );
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          TimeOfDay tempPickedTime = TimeOfDay.fromDateTime(initialDate);
          return _buildBottomPicker(
            context,
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initialDate,
              onDateTimeChanged: (DateTime dateTime) {
                tempPickedTime = TimeOfDay.fromDateTime(dateTime);
              },
            ),
            onConfirm: () {
              Navigator.pop(context, tempPickedTime);
            },
          );
        },
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartTime) {
            selectedStartTime = selectedDateTime;
          } else {
            selectedEndTime = selectedDateTime;
          }
        });
      }
    }
  }

  // Helper function to build Cupertino picker with confirm button
  Widget _buildBottomPicker(BuildContext context, Widget picker, {required Function() onConfirm}) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Confirm'),
                onPressed: onConfirm,
              ),
            ],
          ),
          Divider(height: 1),
          Expanded(child: picker),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Start:'),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    selectedStartTime != null
                        ? DateFormat('dd MMM yyyy, hh:mm a').format(selectedStartTime!)
                        : 'Not selected',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _pickDateAndTime(context, true),
                  child: Text('Pick Time'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('End:'),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    selectedEndTime != null
                        ? DateFormat('dd MMM yyyy, hh:mm a').format(selectedEndTime!)
                        : 'Not selected',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _pickDateAndTime(context, false),
                  child: Text('Pick Time'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                selectedStartTime != null &&
                selectedEndTime != null) {
              widget.onSave(titleController.text, selectedStartTime!, selectedEndTime!);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all the fields')),
              );
            }
          },
        ),
      ],
    );
  }
}
