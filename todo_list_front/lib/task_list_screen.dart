import 'package:flutter/material.dart';
import 'task_model.dart';
import 'api_service.dart';
import 'add_task_dialog.dart';
import 'edit_task_dialog.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final apiService = ApiService(); 
      final fetchedTasks = await apiService.fetchTasks(); 
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  void _addTask() async {
    final task = await showDialog<Task>(
      context: context,
      builder: (context) => AddTaskDialog(),
    );
    if (task != null) {
      final apiService = ApiService();
      await apiService.addTask(task);
      _loadTasks(); // Refresh the list after adding the task
    }
  }

  void _editTask(Task task) async {
    final updatedTask = await showDialog<Task>(
      context: context,
      builder: (context) => EditTaskDialog(task: task),
    );
    if (updatedTask != null) {
      final apiService = ApiService();
      await apiService.updateTask(updatedTask);
      _loadTasks(); 
    }
  }

  Future<void> _deleteTask(int id) async {
    final apiService = ApiService();
    await apiService.deleteTask(id);
    _loadTasks(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: tasks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.5, 
                    child: Card(
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        subtitle: Text(
                          task.description,
                          style: TextStyle(color: Colors.black54),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            IconButton(
                              icon: Icon(
                                task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: task.completed ? Colors.green : Colors.red,
                              ),
                              onPressed: () {
                                _editTask(task); // Edit task on tap
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteTask(task.id); // Delete task when pressed
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          _editTask(task); // Edit task on tap
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask, // Trigger add task form
        child: Icon(Icons.add),
      ),
    );
  }
}
