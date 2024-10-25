import 'package:hive/hive.dart';
import 'package:todo_app/model/todo_model.dart';

class HiveService {
  Box<Todo>? _todoBox;

  // Initialize the Hive box
  Future<void> init() async {
    if (!Hive.isBoxOpen('todobox')) {
      _todoBox = await Hive.openBox<Todo>('todobox');
    } else {
      _todoBox = Hive.box<Todo>('todobox');
    }
  }

  // Save todo
  void saveTodo(Todo todo) {
    _todoBox?.add(todo);
  }

  // Update todo at a specific index
  void updateTodo(int index, Todo todo) {
    _todoBox?.putAt(index, todo);
  }

  // Retrieve todos
  List<Todo> getTodos() {
    return _todoBox?.values.toList() ?? [];
  }
}
