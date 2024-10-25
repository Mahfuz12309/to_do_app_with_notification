import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/pages/homepage.dart'; 
import 'package:todo_app/services/hive_service.dart'; // Import HiveService

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter()); // Register the adapter for your Todo model
  
  final hiveService = HiveService(); // Create an instance of HiveService
  await hiveService.init(); // Initialize the Hive box

  runApp(MyApp(hiveService: hiveService)); // Pass the hiveService to MyApp
}

class MyApp extends StatelessWidget {
  final HiveService hiveService; // Add HiveService as a property

  MyApp({required this.hiveService}); // Constructor to initialize HiveService

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'You Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(hiveService: hiveService), // Pass HiveService to HomePage
      debugShowCheckedModeBanner: false,
    );
  }
}
