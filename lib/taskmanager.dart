import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/crudbar.dart';
import 'package:pepelist/objects/meeting_data_source.dart';
import 'package:pepelist/objects/task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'objects/meeting.dart';
import 'widgets/taskTile.dart';

class TaskManager extends StatefulWidget {
  final Data data;
  final Function addTask;
  final Function editTask;
  final Function deleteTask;
  final Function select;
  final Task selectedTask;
  final String ownerEmail;
  final Function resetSelectedTask;
  final TextEditingController titleC;
  final TextEditingController categoryC;
  final TextEditingController sdateC;
  final Function resetCRUD;
  final Function sortList;

  TaskManager({
    @required this.data,
    @required this.addTask,
    @required this.editTask,
    @required this.deleteTask,
    @required this.select,
    @required this.selectedTask,
    @required this.ownerEmail,
    @required this.resetSelectedTask,
    @required this.titleC,
    @required this.categoryC,
    @required this.sdateC,
    @required this.resetCRUD,
    @required this.sortList,
  });

  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  bool isCalendar = false;
  bool filterCompleted = false;
  String categoryFilter;
  List<Meeting> meetings;
  TextEditingController titleFilterController = TextEditingController();
  TextEditingController categoryFilterController = TextEditingController();

  @override
  void initState() {
    categoryFilterController.text = 'All';
    super.initState();
  }

  @override
  void dispose() {
    titleFilterController.dispose();
    categoryFilterController.dispose();
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
                        image: NetworkImage('assets/images/banners1.png'),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('EEEE, d MMM, yyyy')
                              .format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'Hide Completed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 8),
                            CupertinoSwitch(
                              trackColor: Colors.grey[500],
                              activeColor: Colors.blueAccent[100],
                              value: filterCompleted,
                              onChanged: (value) {
                                setState(() {
                                  filterCompleted = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 50),
                        Row(
                          children: [
                            Text(
                              'Calendar Mode',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 8),
                            CupertinoSwitch(
                              trackColor: Colors.grey[500],
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(32),
                    height: size.height - 150,
                    color: isCalendar ? Colors.grey[200] : Colors.grey[200],
                    child: !isCalendar
                        ? SingleChildScrollView(
                            child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 65,
                                  color: Colors.grey[50],
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: size.width / 4,
                                        child: TextField(
                                          controller: titleFilterController,
                                          toolbarOptions:
                                              ToolbarOptions(selectAll: true),
                                          decoration: InputDecoration(
                                            labelText: 'Filter Title...',
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.blueAccent,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('Filter Category:'),
                                          SizedBox(width: 16),
                                          DropdownButton(
                                            hint: Text(
                                                categoryFilterController.text),
                                            icon: Icon(Icons.arrow_drop_down),
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('All'),
                                                value: 'All',
                                              ),
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
                                                categoryFilterController.text =
                                                    value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 24),
                              Column(
                                children: filterCompleted
                                    ? _buildFilteredTaskTiles(
                                                    titleFilterController.text,
                                                    categoryFilterController
                                                        .text)
                                                .length ==
                                            0
                                        ? [
                                            SizedBox(height: 300),
                                            Center(
                                                child:
                                                    Text('No Upcoming Tasks'))
                                          ]
                                        : _buildFilteredTaskTiles(
                                            titleFilterController.text,
                                            categoryFilterController.text)
                                    : _buildAllTaskTiles(
                                                    titleFilterController.text,
                                                    categoryFilterController
                                                        .text)
                                                .length ==
                                            0
                                        ? [
                                            SizedBox(height: 300),
                                            Center(child: Text('No Tasks'))
                                          ]
                                        : _buildAllTaskTiles(
                                            titleFilterController.text,
                                            categoryFilterController.text),
                              ),
                            ],
                          ))
                        : SfCalendar(
                            view: CalendarView.month,
                            allowViewNavigation: false,
                            headerHeight: 50,
                            showNavigationArrow: true,
                            dataSource: MeetingDataSource(
                              filterCompleted
                                  ? _getFilteredDataSource()
                                  : _getAllDataSource(),
                            ),
                            // by default the month appointment display mode set as Indicator, we can
                            // change the display mode as appointment using the appointment display
                            // mode property
                            monthViewSettings: MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment),
                          ),
                  ),
                ],
              ),
            ),
          ),
          CRUDBar(
            addTask: widget.addTask,
            editTask: widget.editTask,
            deleteTask: widget.deleteTask,
            selectedTask: widget.selectedTask,
            reset: reset,
            ownerEmail: widget.ownerEmail,
            resetSelectedTask: widget.resetSelectedTask,
            categoryC: widget.categoryC,
            sdateC: widget.sdateC,
            titleC: widget.titleC,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAllTaskTiles(String titleFiler, String categoryFilter) {
    List<Widget> tiles = [];

    for (Task t in widget.data.tasks) {
      if (categoryFilter == 'All' || t.category == categoryFilter) {
        if (t.title.toLowerCase().contains(titleFiler.toLowerCase()) ||
            titleFiler == '') {
          tiles.add(TaskTile(
            task: t,
            select: widget.select,
            resetParent: reset,
            resetCRUD: widget.resetCRUD,
          ));
        }
      }
    }

    return tiles;
  }

  List<Widget> _buildFilteredTaskTiles(
      String titleFiler, String categoryFilter) {
    List<Widget> tiles = [];

    for (Task t in widget.data.tasks) {
      if (!t.completed) {
        if (categoryFilter == 'All' || t.category == categoryFilter) {
          if (t.title.toLowerCase().contains(titleFiler.toLowerCase()) ||
              titleFiler == '') {
            tiles.add(TaskTile(
              task: t,
              select: widget.select,
              resetParent: reset,
              resetCRUD: widget.resetCRUD,
            ));
          }
        }
      }
    }

    return tiles;
  }

  List<Meeting> _getAllDataSource() {
    meetings = <Meeting>[];

    for (Task t in widget.data.tasks) {
      meetings.add(
        Meeting(
          title: t.title,
          category: t.category,
          dueDate: t.dueDate,
        ),
      );
    }

    return meetings;
  }

  List<Meeting> _getFilteredDataSource() {
    meetings = <Meeting>[];

    for (Task t in widget.data.tasks) {
      if (!t.completed) {
        meetings.add(
          Meeting(
            title: t.title,
            category: t.category,
            dueDate: t.dueDate,
          ),
        );
      }
    }

    return meetings;
  }

  void reset() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      widget.sortList();
    });
  }
}
