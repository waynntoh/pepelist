import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function select;
  final Function reset;

  const TaskTile(
      {@required this.task, @required this.select, @required this.reset});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool overdue = false;
  int days;

  @override
  void initState() {
    if (DateTime.now().isAfter(widget.task.dueDate) && !widget.task.completed) {
      setState(() {
        overdue = true;
        days = DateTime.now().difference(widget.task.dueDate).inDays;
      });
    }
    super.initState();
  }

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
              width: 140,
              decoration: BoxDecoration(
                color: widget.task.completed
                    ? Colors.greenAccent[100]
                    : overdue
                        ? Colors.redAccent[100]
                        : Colors.amberAccent[100],
                border: Border.all(
                  width: .5,
                  color: widget.task.completed
                      ? Colors.greenAccent[700]
                      : overdue
                          ? Colors.redAccent[700]
                          : Colors.amberAccent[700],
                ),
              ),
              child: Center(
                child: Text(
                  widget.task.completed
                      ? 'Completed'
                      : overdue
                          ? 'Overdue [' + days.toString() + ' day/s]'
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

                  if (DateTime.now().isAfter(widget.task.dueDate) &&
                      !widget.task.completed) {
                    setState(() {
                      overdue = true;
                      days =
                          DateTime.now().difference(widget.task.dueDate).inDays;
                    });
                  }

                  widget.reset();
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
