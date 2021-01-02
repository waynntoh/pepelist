import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/objects/task.dart';
import 'package:pepelist/widgets/taskTile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  Tasks tasks = new Tasks();
  bool isCalendar = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String dateString = DateFormat('dd/MM/yyyy').format(DateTime.now());

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

    return Container(
      height: size.height,
      width: size.width - size.width / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              width: 50,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('banner.png'),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('EEEE, d MMM, yyyy')
                              .format(DateTime.now()),
                          style: TextStyle(fontSize: 28),
                        ),
                        CupertinoSwitch(
                          activeColor: Colors.blueAccent[100],
                          value: isCalendar,
                          onChanged: (value) {
                            setState(() {
                              isCalendar = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        isCalendar ? EdgeInsets.all(64) : EdgeInsets.all(16),
                    height: size.height - 150,
                    color: Colors.lightBlue[50],
                    child: !isCalendar
                        ? Column(
                            children: _buildTaskTiles(),
                          )
                        : SfCalendar(
                            view: CalendarView.month,
                            allowViewNavigation: false,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: size.height,
              width: 50,
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 64),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.add_alert,
                      color: Colors.blueAccent,
                      size: 70,
                    ),
                    SizedBox(height: 16),
                    Text('ADD NEW TASK'),
                    SizedBox(height: 64),
                    TextFormField(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category'),
                        DropdownButton(
                          hint: Text(categoryController.text),
                          icon: Icon(Icons.arrow_drop_down),
                          items: [
                            DropdownMenuItem(
                              child: Text('Groceries'),
                              value: 'Groceries',
                            ),
                            DropdownMenuItem(
                              child: Text('Work'),
                              value: 'Work',
                            ),
                            DropdownMenuItem(
                              child: Text('Personal'),
                              value: 'Personal',
                            ),
                            DropdownMenuItem(
                              child: Text('Home'),
                              value: 'Home',
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
                    Row(
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
                    RaisedButton(
                      color: Colors.blueAccent[100],
                      child: Text('ADD'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            Task newTask = Task(
                              'hidethepainharold@gmail.com',
                              titleController.text,
                              categoryController.text,
                              DateTime.now(),
                              selectedDate,
                            );

                            tasks.tasks.add(newTask);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskTiles() {
    List<Widget> tiles = [];

    for (Task t in tasks.tasks) {
      tiles.add(TaskTile(t));
    }

    return tiles;
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
}
