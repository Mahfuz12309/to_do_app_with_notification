import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTodoDialog extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final DateTime currentStartTime;
  final DateTime currentEndTime;
  final Function(String, String, DateTime, DateTime) onSave;

  EditTodoDialog({
    required this.currentTitle,
    required this.currentDescription,
    required this.currentStartTime,
    required this.currentEndTime,
    required this.onSave,
  });

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.currentTitle);
    descriptionController = TextEditingController(text: widget.currentDescription);
    selectedStartTime = widget.currentStartTime;
    selectedEndTime = widget.currentEndTime;
  }

  Future<void> _pickDateAndTime(BuildContext context, bool isStartTime) async {
    DateTime initialDate = isStartTime ? selectedStartTime! : selectedEndTime!;

    DateTime? pickedDate = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        DateTime tempPickedDate = initialDate;
        return _buildBottomPicker(
          context,
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: initialDate,
            minimumDate: DateTime.now(),
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
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedDate;
        } else {
          selectedEndTime = pickedDate;
        }
      });
    }
  }

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
      title: Text('Edit Task'),
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
              widget.onSave(
                titleController.text,
                descriptionController.text,
                selectedStartTime!,
                selectedEndTime!,
              );
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
