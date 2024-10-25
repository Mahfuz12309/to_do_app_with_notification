import 'package:flutter/material.dart';

class TaskDetailDialog extends StatelessWidget {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;

  TaskDetailDialog({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Task Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title: $title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Description: $description'),
          SizedBox(height: 8.0),
          Text('Start Time: ${startTime.toString()}'),
          SizedBox(height: 8.0),
          Text('End Time: ${endTime.toString()}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
