import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';
import 'package:http/http.dart' as http;

class TaskTile extends StatefulWidget {
  final Task task;
  final Function select;
  final Function resetParent;
  final Function resetCRUD;

  const TaskTile({
    @required this.task,
    @required this.select,
    @required this.resetParent,
    @required this.resetCRUD,
  });

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool submitting = false;

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
                      : DateFormat('dd/MM/yyyy').format(widget.task.dueDate),
                ),
              ),
            ),
            SizedBox(width: 360),
            SizedBox(
              width: 50,
              child: submitting
                  ? SpinKitHourGlass(
                      color: Colors.blue,
                      size: 30,
                    )
                  : Checkbox(
                      value: (widget.task.completed),
                      onChanged: (value) {
                        toggleCompleted(value);
                      },
                    ),
            ),
          ],
        ),
      ),
      onPressed: () {
        setState(() {
          widget.select(widget.task);
          widget.resetCRUD();
        });
      },
    );
  }

  void toggleCompleted(bool b) {
    setState(() {
      submitting = true;
    });
    http.post('https://techvestigate.com/pepelist/php/editTask.php', body: {
      "dc": widget.task.dateCreated.toString(),
      "col": 'COMPLETED',
      "new_data": b ? '1' : '0',
    }).then((res) {
      if (res.body == 'success') {
        widget.task.toggleTaskCompletion(b);
        widget.resetParent();
      } else {
        print('[-] Get tasks failed');
      }
      setState(() {
        submitting = false;
      });
    }).catchError((err) {
      print(err);
    });
  }
}
