import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/hive_service.dart';
import 'package:todo_app/services/notification_service.dart';

class AddTodoPage extends StatefulWidget {
  final Function(DateTime) onSave;

  AddTodoPage({required this.onSave});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(hours: 1));

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTodo = Todo(
        title: _title,
        description: _description,
        startTime: _startTime,
        endTime: _endTime,
      );

      HiveService.addTask(newTodo);
      NotificationService.scheduleNotification(newTodo.startTime, newTodo.title);
      widget.onSave(_startTime);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveTodo,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
