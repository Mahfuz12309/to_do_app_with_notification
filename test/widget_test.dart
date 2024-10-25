import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/hive_service.dart';
import 'package:todo_app/main.dart';

class MockHiveService extends HiveService {
  @override
  Future<void> init() async {
    // Mock initialization for testing
  }

  @override
  List<Todo> getTodos() {
    return []; // Return an empty list or mock data for testing
  }

  @override
  void saveTodo(Todo todo) {
    // Mock save functionality
  }

  @override
  void updateTodo(int index, Todo todo) {
    // Mock update functionality
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a mock instance of HiveService
    final mockHiveService = MockHiveService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(hiveService: mockHiveService)); // Pass the mock instance

    // Verify the app runs and shows the expected UI.
    expect(find.text('You Do'), findsOneWidget);
  });
}
