import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';
import 'package:http/http.dart' as http;
import 'utils/constants.dart';

class CRUDBar extends StatefulWidget {
  final Function addTask;
  final Function editTask;
  final Function deleteTask;
  final Task selectedTask;
  final Function reset;
  final String ownerEmail;
  final Function resetSelectedTask;

  final TextEditingController titleC;
  final TextEditingController categoryC;
  final TextEditingController sdateC;

  CRUDBar({
    @required this.addTask,
    @required this.editTask,
    @required this.deleteTask,
    @required this.selectedTask,
    @required this.reset,
    @required this.ownerEmail,
    @required this.resetSelectedTask,
    @required this.titleC,
    @required this.categoryC,
    @required this.sdateC,
  });

  @override
  _CRUDBarState createState() => _CRUDBarState();
}

class _CRUDBarState extends State<CRUDBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String state = 'Add';
  bool confirmedDeletion = false;
  bool submitting = false;

  @override
  void initState() {
    if (widget.categoryC.text == '' || widget.categoryC.text == null) {
      widget.categoryC.text = 'Personal';
    }
    if (widget.sdateC.text == '' || widget.sdateC.text == null) {
      widget.sdateC.text = DateTime.now().toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: .1,
            color: Colors.black,
          ),
        ),
        height: size.height,
        width: 50,
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 48),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                state == 'Add'
                    ? Icons.add
                    : state == 'Edit'
                        ? Icons.edit
                        : Icons.delete,
                color: Colors.blueAccent,
                size: 70,
              ),
              SizedBox(height: 16),
              DropdownButton(
                hint: Text(state),
                icon: Icon(Icons.arrow_drop_down),
                items: [
                  DropdownMenuItem(
                    child: Text('Add'),
                    value: 'Add',
                  ),
                  DropdownMenuItem(
                    child: Text('Edit'),
                    value: 'Edit',
                  ),
                  DropdownMenuItem(
                    child: Text('Delete'),
                    value: 'Delete',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    state = value;
                  });
                },
              ),
              SizedBox(height: 64),
              state == 'Edit' || state == 'Delete'
                  ? Text(
                      'Selected Task: [' +
                          (widget.selectedTask != null
                              ? widget.selectedTask.title + ']'
                              : 'None]'),
                    )
                  : Container(),
              SizedBox(height: 16),
              state == 'Delete'
                  ? Container()
                  : TextFormField(
                      controller: widget.titleC,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid Title';
                        }
                        return null;
                      },
                    ),
              SizedBox(height: 16),
              state == 'Delete'
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category'),
                        DropdownButton(
                          hint: Text(widget.categoryC.text),
                          icon: Icon(Icons.arrow_drop_down),
                          items: [
                            DropdownMenuItem(
                              child: Text('Personal'),
                              value: 'Personal',
                            ),
                            DropdownMenuItem(
                              child: Text('Groceries'),
                              value: 'Groceries',
                            ),
                            DropdownMenuItem(
                              child: Text('Work'),
                              value: 'Work',
                            ),
                            DropdownMenuItem(
                              child: Text('School'),
                              value: 'School',
                            ),
                            DropdownMenuItem(
                              child: Text('Home'),
                              value: 'Home',
                            ),
                            DropdownMenuItem(
                              child: Text('Other'),
                              value: 'Other',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              widget.categoryC.text = value;
                            });
                          },
                        ),
                      ],
                    ),
              SizedBox(height: 18),
              state == 'Delete'
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date Due'),
                        FlatButton(
                          color: Colors.lightBlueAccent[100],
                          onPressed: () => _selectDate(context),
                          child: Text(DateTime.parse(widget.sdateC.text) != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(widget.sdateC.text))
                              : DateFormat('dd/MM/yyyy')
                                  .format(DateTime.now())),
                        ),
                      ],
                    ),
              SizedBox(height: 48),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      confirmedDeletion ? Colors.redAccent : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  mouseCursor:
                      submitting ? null : MaterialStateMouseCursor.clickable,
                  child: submitting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Loading',
                              style: kHeaderTextStyle.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 16),
                            kSpinKitLoader,
                          ],
                        )
                      : Center(
                          child: Text(
                            state == 'Add'
                                ? 'ADD'
                                : state == 'Edit'
                                    ? 'SAVE CHANGES'
                                    : confirmedDeletion
                                        ? '*CONFIRM DELETION*'
                                        : 'DELETE',
                            style: kHeaderTextStyle.copyWith(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  onTap: () {
                    if (!submitting) {
                      // DELETE
                      if (state == 'Delete') {
                        setState(() {
                          if (!confirmedDeletion) {
                            confirmedDeletion = true;
                          } else {
                            dbDeleteTask();
                          }
                        });
                      }

                      // EDIT
                      if (state == 'Edit' && widget.selectedTask != null) {
                        dbEditTask();
                      } else {
                        print('no selected task');
                      }

                      // ADD
                      if (state == 'Add' && _formKey.currentState.validate()) {
                        dbAddTask();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.sdateC.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != DateTime.parse(widget.sdateC.text))
      setState(() {
        widget.sdateC.text = picked.toString();
      });
  }

  void dbAddTask() {
    setState(() {
      submitting = true;
    });
    http.post('https://techvestigate.com/pepelist/php/addTask.php', body: {
      "owneremail": widget.ownerEmail,
      "title": widget.titleC.text,
      "category": widget.categoryC.text,
      "duedate": widget.sdateC.text,
    }).then((res) {
      if (res.body == "success") {
        setState(() {
          // Local
          Task newTask = Task(
            widget.ownerEmail,
            widget.titleC.text,
            widget.categoryC.text,
            DateTime.now(),
            DateTime.parse(widget.sdateC.text),
            false,
          );
          widget.addTask(newTask);

          // Reset
          widget.titleC.text = '';
          widget.categoryC.text = 'Personal';
          widget.sdateC.text = DateTime.now().toString();
          widget.reset();
        });
      } else {
        print('[-] Add task failed');
      }
      setState(() {
        submitting = false;
      });
    }).catchError((err) {
      print(err);
    });
  }

  void dbEditTask() {
    setState(() {
      submitting = true;
    });

    bool editTitle = widget.selectedTask.title != widget.titleC.text;
    bool editCategory = widget.selectedTask.category != widget.categoryC.text;
    bool editDueDate =
        widget.selectedTask.dueDate != DateTime.parse(widget.sdateC.text);

    http.post('https://techvestigate.com/pepelist/php/editTask.php', body: {
      "dc": widget.selectedTask.dateCreated.toString(),
      "new_title": editTitle ? widget.titleC.text : widget.selectedTask.title,
      "new_category":
          editCategory ? widget.categoryC.text : widget.selectedTask.category,
      "new_duedate": editDueDate
          ? widget.sdateC.text
          : widget.selectedTask.dueDate.toString(),
    }).then((res) {
      if (res.body == 'success') {
        setState(() {
          widget.editTask(
            widget.selectedTask,
            editTitle ? widget.titleC.text : widget.selectedTask.title,
            editCategory ? widget.categoryC.text : widget.selectedTask.category,
            editDueDate
                ? DateTime.parse(widget.sdateC.text)
                : widget.selectedTask.dueDate,
          );

          // Reset
          widget.titleC.text = '';
          widget.categoryC.text = 'Personal';
          widget.sdateC.text = DateTime.now().toString();
          widget.reset();
          widget.resetSelectedTask();
        });
      } else {
        print('[-] Edit task failed');
      }
      setState(() {
        submitting = false;
      });
      widget.reset();
    }).catchError((err) {
      print(err);
    });
  }

  void dbDeleteTask() {
    setState(() {
      submitting = true;
    });
    http.post('https://techvestigate.com/pepelist/php/deleteTask.php', body: {
      "dc": widget.selectedTask.dateCreated.toString(),
    }).then((res) {
      if (res.body == "success") {
        setState(() {
          // Local
          widget.deleteTask(widget.selectedTask);
          widget.reset();
          confirmedDeletion = false;
        });
        // ignore: unnecessary_statements
        widget.resetSelectedTask;
      } else {
        print('[-] Delete task failed');
      }
      setState(() {
        submitting = false;
      });
    }).catchError((err) {
      print(err);
    });
  }
}
