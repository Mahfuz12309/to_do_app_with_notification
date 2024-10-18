import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime startTime;

  @HiveField(3)
  DateTime endTime;

  @HiveField(4)
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
  });
}
