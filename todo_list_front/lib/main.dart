import 'package:flutter/material.dart';
import 'task_model.dart'; // Modelo da Tarefa
import 'api_service.dart'; // Serviço da API
import 'task_list_screen.dart'; // Tarefa List Screen

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(), // Main screen
    );
  }
}
