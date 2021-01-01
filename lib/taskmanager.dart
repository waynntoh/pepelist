import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Tasks tasks = new Tasks();

    for (Task t in tasks.tasks) {
      print(t.title);
    }

    return Container(
      color: Color(0xFFF1F4F8),
      height: size.height,
      width: size.width - size.width / 6,
      child: Center(
        child: Text('Task Manager'),
      ),
    );
  }
}
