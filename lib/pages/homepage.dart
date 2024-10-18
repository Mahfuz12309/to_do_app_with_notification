import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/hive_service.dart';

class HomePage extends StatelessWidget {
  final DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Todo> todosForToday = HiveService.getTodosForDate(selectedDate);  // Get today's todos

    return Scaffold(
      appBar: AppBar(
        title: Text('You Do'),
      ),
      body: Column(
        children: [
          // Calendar widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: selectedDate,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              // Handle date selection here
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // To-do list for selected date
          Expanded(
            child: ListView.builder(
              itemCount: todosForToday.length,
              itemBuilder: (context, index) {
                final todo = todosForToday[index];
                return TodoItemWidget(
                  todo: todo,
                  onDelete: () {
                    // Implement delete functionality
                  },
                  onTap: () {
                    // Show task details in a pop-up
                  },
                  onCompleteToggle: (bool? value) {
                    // Toggle task completion
                  },
                );
              },
            ),
          ),
        ],
      ),
      
      // Floating button to add new task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Todo page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
