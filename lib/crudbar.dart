import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';
import 'package:http/http.dart' as http;
import 'package:pepelist/utils/constants.dart';

class CRUDBar extends StatefulWidget {
  final Function addTask;
  final Function editTask;
  final Function deleteTask;
  final Task selectedTask;
  final Function reset;
  final String ownerEmail;

  CRUDBar({
    @required this.addTask,
    @required this.editTask,
    @required this.deleteTask,
    @required this.selectedTask,
    @required this.reset,
    @required this.ownerEmail,
  });

  @override
  _CRUDBarState createState() => _CRUDBarState();
}

class _CRUDBarState extends State<CRUDBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String state = 'Add';

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String dateString = DateFormat('dd/MM/yyyy').format(DateTime.now());
  bool confirmedDeletion = false;
  bool submitting = false;

  @override
  void initState() {
    categoryController.text = 'Personal';
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (state == 'Edit') {
      titleController.text = widget.selectedTask.title;
    }

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
                      controller: titleController,
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
                          hint: Text(categoryController.text),
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
                              categoryController.text = value;
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
                          child: Text(dateString),
                        ),
                      ],
                    ),
              SizedBox(height: 48),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
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
                    if (_formKey.currentState.validate() && !submitting) {
                      if (submitting) {
                        print('submitting, blocking clicks');
                      } else {
                        if (state == 'Delete') {
                          // TODO: Delete task from database
                          setState(() {
                            if (!confirmedDeletion) {
                              confirmedDeletion = true;
                            } else {
                              widget.deleteTask(widget.selectedTask);

                              // RESET
                              confirmedDeletion = false;
                            }
                          });
                        } else {
                          if (_formKey.currentState.validate()) {
                            // ADD
                            if (state == 'Add') {
                              print('add');
                              dbAddTask();
                            }

                            // EDIT
                            // TODO: Edit task in database

                            if (state == 'Edit') {
                              setState(() {
                                widget.editTask(
                                  widget.selectedTask,
                                  titleController.text,
                                  categoryController.text,
                                  selectedDate,
                                );

                                // Reset
                                titleController.text = '';
                                categoryController.text = 'Personal';
                                widget.reset();
                              });
                            }
                          }
                        }
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
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateString = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

  void dbAddTask() {
    setState(() {
      submitting = true;
    });
    http.post('https://techvestigate.com/pepelist/php/addTask.php', body: {
      "owneremail": widget.ownerEmail,
      "title": titleController.text,
      "category": categoryController.text,
      "duedate": selectedDate.microsecondsSinceEpoch.toString(),
      "completed": '0',
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        print('[+] Add task successful');
        setState(() {
          // Local
          Task newTask = Task(
            widget.ownerEmail,
            titleController.text,
            categoryController.text,
            DateTime.now(),
            selectedDate,
          );
          widget.addTask(newTask);

          // Reset
          titleController.text = '';
          categoryController.text = 'Personal';
        });
        widget.reset();
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
}
