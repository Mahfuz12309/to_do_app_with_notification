import 'package:flutter/material.dart';
import 'package:todo_app/pages/homepage.dart';
import 'package:todo_app/services/hive_service.dart';
import 'package:todo_app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive and Notification Services
  await HiveService.initHive();
  await NotificationService.initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
