// edit_todo_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo_model.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;  // Pass the todo item to be edited

  EditTodoPage({required this.todo});

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _title = widget.todo.title;
    _description = widget.todo.description;
    _startTime = widget.todo.startTime;
    _endTime = widget.todo.endTime;
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartTime ? _startTime : _endTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(isStartTime ? _startTime : _endTime),
      );
      if (time != null) {
        setState(() {
          if (isStartTime) {
            _startTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
          } else {
            _endTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
          }
        });
      }
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.todo.title = _title;
      widget.todo.description = _description;
      widget.todo.startTime = _startTime;
      widget.todo.endTime = _endTime;
      
      Navigator.pop(context, widget.todo);  // Pass updated todo back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              ListTile(
                title: Text('Start Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_startTime)}'),
                trailing: Icon(Icons.edit),
                onTap: () => _selectDateTime(context, true),
              ),
              ListTile(
                title: Text('End Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_endTime)}'),
                trailing: Icon(Icons.edit),
                onTap: () => _selectDateTime(context, false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
