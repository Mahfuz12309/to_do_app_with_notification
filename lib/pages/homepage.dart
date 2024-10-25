import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/services/hive_service.dart';
import 'edit_todo.dart';

class HomePage extends StatefulWidget {
  final HiveService hiveService;

  HomePage({required this.hiveService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todosForToday = [];
  List<Todo> filteredTodos = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> loadTodos() async {
    List<Todo> storedTodos = widget.hiveService.getTodos();
    setState(() {
      todosForToday = storedTodos
          .where((todo) =>
              todo.startTime.year == DateTime.now().year &&
              todo.startTime.month == DateTime.now().month &&
              todo.startTime.day == DateTime.now().day)
          .toList();
      filteredTodos =
          todosForToday; // Initially, filteredTodos is the same as todosForToday.
    });
  }

  // Define colors for different priority levels
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1: // Low Priority
        return Colors.green;
      case 2: // Medium Priority
        return Colors.orange;
      case 3: // High Priority
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Search function
  void filterTasks(String query) {
    setState(() {
      searchQuery = query;
      filteredTodos = todosForToday
          .where(
              (todo) => todo.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AddTodoDialog(
          onSave: (String title, DateTime startTime, DateTime endTime) {
            setState(() {
              final newTodo = Todo(
                title: title,
                description: '',
                startTime: startTime,
                endTime: endTime,
                priority: 1, // Default priority to 1 (Low)
              );
              todosForToday.add(newTodo);
              filteredTodos.add(newTodo); // Add to filtered list too.
              widget.hiveService.saveTodo(newTodo);
            });
          },
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(BuildContext context, int index) async {
    final currentTodo = filteredTodos[index];
    await showDialog(
      context: context,
      builder: (context) {
        return EditTodoDialog(
          currentTitle: currentTodo.title,
          currentDescription: currentTodo.description,
          currentStartTime: currentTodo.startTime,
          currentEndTime: currentTodo.endTime,
          onSave: (String updatedTitle, String updatedDescription,
              DateTime updatedStartTime, DateTime updatedEndTime) {
            setState(() {
              todosForToday[index].title = updatedTitle;
              todosForToday[index].description = updatedDescription;
              todosForToday[index].startTime = updatedStartTime;
              todosForToday[index].endTime = updatedEndTime;
              widget.hiveService.updateTodo(index, todosForToday[index]);
              loadTodos(); // Reload todos after editing
            });
          },
        );
      },
    );
  }

  String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "You have ${todosForToday.length} tasks for today",
          style: TextStyle(color: Colors.white,),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
    decoration: InputDecoration(
      hintText: "Search task...",
      prefixIcon: Icon(Icons.search),
      filled: true,
      fillColor: Colors.white12, // Background color inside the text field
      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    
      
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.grey.shade300, // Inner border color when not focused
          width: 1.0,
        ),
      ),
    ),
    onChanged: (query) {
      filterTasks(query);
    },
  ),
),
          Expanded(
            child: filteredTodos.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Card background color
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 5), // Shadow positioning
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Priority color bar
                              Container(
                                width: 5,
                                height: 80, // Adjust height as per design
                                decoration: BoxDecoration(
                                  color: getPriorityColor(todo.priority),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    todo.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        todo.description.isNotEmpty
                                            ? todo.description
                                            : 'No description',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Start: ${formatTime(todo.startTime)} - End: ${formatTime(todo.endTime)}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () {
                                          _showEditTaskDialog(context, index);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            // widget.hiveService.deleteTodo(index);
                                            todosForToday.removeAt(index);
                                            filteredTodos.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No tasks found',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
