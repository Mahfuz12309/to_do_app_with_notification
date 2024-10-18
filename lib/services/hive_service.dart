import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/todo_model.dart';

class HiveService {
  static const String todoBoxName = "todoBox";

  // Initialize Hive and open the to-do box
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());  // Register the Todo model adapter
    await Hive.openBox<Todo>(todoBoxName);  // Open the box for to-dos
  }

  // Add a new to-do item
  static Future<void> addTodoItem(Todo todo) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.add(todo);
  }

  // Get all to-do items from the box
  static List<Todo> getAllTodos() {
    final box = Hive.box<Todo>(todoBoxName);
    return box.values.toList().cast<Todo>();
  }

  // Get to-do items for a specific date
  static List<Todo> getTodosForDate(DateTime date) {
    final box = Hive.box<Todo>(todoBoxName);
    return box.values
        .where((todo) => todo.startTime.day == date.day && todo.startTime.month == date.month && todo.startTime.year == date.year)
        .toList()
        .cast<Todo>();
  }

  // Update an existing to-do item
  static Future<void> updateTodoItem(int index, Todo updatedTodo) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.putAt(index, updatedTodo);
  }

  // Delete a to-do item
  static Future<void> deleteTodoItem(int index) async {
    final box = Hive.box<Todo>(todoBoxName);
    await box.deleteAt(index);
  }

  // Close the Hive box (usually called when the app is closing)
  static Future<void> closeHive() async {
    await Hive.close();
  }
}
