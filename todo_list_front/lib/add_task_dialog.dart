import 'package:flutter/material.dart';
import 'task_model.dart'; // Model of the task

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SwitchListTile(
            title: Text('Completed'),
            value: _completed,
            onChanged: (bool value) {
              setState(() {
                _completed = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newTask = Task(
              id: 0, // id is 0 since it's a new task
              title: _titleController.text,
              description: _descriptionController.text,
              completed: _completed,
            );
            Navigator.of(context).pop(newTask); // Return the new task
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without adding a task
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
