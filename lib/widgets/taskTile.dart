import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile(this.task);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: Icon(Icons.local_grocery_store),
      title: Text(widget.task.title),
      value: widget.task.completed,
      subtitle: Text(widget.task.category),
      onChanged: (b) {
        setState(() {
          widget.task.toggleTaskCompletion(b);
        });
      },
    );
  }
}
