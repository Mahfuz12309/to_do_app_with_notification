import 'package:hive/hive.dart';

part 'todo_model.g.dart';  // This is for the generated code

@HiveType(typeId: 0)  // Specify the type ID for this Hive object
class Todo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime startTime;

  @HiveField(3)
  late DateTime endTime;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)  // New field for priority
  late int priority;

  Todo({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,  // Default value is false
    this.priority = 1,  // Default priority is 1 (Low)
  });
}
