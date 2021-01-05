import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function select;
  final Function resetParent;

  const TaskTile(
      {@required this.task, @required this.select, @required this.resetParent});

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
                    : DateTime.now().isAfter(widget.task.dueDate)
                        ? Colors.redAccent[100]
                        : Colors.amberAccent[100],
                border: Border.all(
                  width: .5,
                  color: widget.task.completed
                      ? Colors.greenAccent[700]
                      : DateTime.now().isAfter(widget.task.dueDate)
                          ? Colors.redAccent[700]
                          : Colors.amberAccent[700],
                ),
              ),
              child: Center(
                child: Text(
                  widget.task.completed
                      ? 'Completed'
                      : DateTime.now().isAfter(widget.task.dueDate)
                          ? 'Overdue'
                          : DateFormat('dd/MM/yyyy')
                              .format(widget.task.dueDate),
                ),
              ),
            ),
            SizedBox(width: 360),
            Checkbox(
              value: (widget.task.completed),
              onChanged: (value) {
                setState(() {
                  widget.task.toggleTaskCompletion(value);

                  widget.resetParent();
                });
              },
            )
          ],
        ),
      ),
      onPressed: () {
        setState(() {
          widget.select(widget.task);
        });
      },
    );
  }
}
