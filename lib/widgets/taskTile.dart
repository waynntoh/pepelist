import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return OutlineButton(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        height: 65,
        width: double.infinity,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  widget.task.category,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 35,
              width: 120,
              decoration: BoxDecoration(
                color: widget.task.completed
                    ? Colors.greenAccent[100]
                    : Colors.amberAccent[100],
                border: Border.all(
                  width: .5,
                  color: widget.task.completed
                      ? Colors.greenAccent[700]
                      : Colors.amberAccent[700],
                ),
              ),
              child: Center(
                child: Text(
                  widget.task.completed
                      ? 'Completed'
                      : DateFormat('dd/MM/yyyy').format(widget.task.dueDate),
                ),
              ),
            ),
            SizedBox(width: 360),
            Checkbox(
              value: (widget.task.completed),
              onChanged: (value) {
                setState(() {
                  widget.task.toggleTaskCompletion(value);
                });
              },
            )
          ],
        ),
      ),
      onPressed: () {
        print('tap');
      },
    );
    // CheckboxListTile(
    //   secondary: Icon(Icons.local_grocery_store),
    //   title: Text(widget.task.title),
    //   value: widget.task.completed,
    //   subtitle: Text(widget.task.category),
    //   onChanged: (b) {
    //     setState(() {
    //       widget.task.toggleTaskCompletion(b);
    //     });
    //   },
    // );
  }
}
