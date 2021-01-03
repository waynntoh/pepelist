import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pepelist/crudbar.dart';
import 'package:pepelist/objects/meeting_data_source.dart';
import 'package:pepelist/objects/task.dart';
import 'package:pepelist/widgets/taskTile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'objects/meeting.dart';

class TaskManager extends StatefulWidget {
  final Tasks tasks;
  final Function addTask;
  final Function editTask;
  final Function deleteTask;
  final Function select;
  final Task selectedTask;

  TaskManager({
    @required this.tasks,
    @required this.addTask,
    @required this.editTask,
    @required this.deleteTask,
    @required this.select,
    @required this.selectedTask,
  });

  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  bool isCalendar = true;
  List<Meeting> meetings;

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
                        isCalendar ? EdgeInsets.all(64) : EdgeInsets.all(32),
                    height: size.height - 150,
                    color: isCalendar ? Colors.grey[200] : Colors.grey[50],
                    child: !isCalendar
                        ? SingleChildScrollView(
                            child: Column(
                              children: _buildTaskTiles(),
                            ),
                          )
                        : SfCalendar(
                            view: CalendarView.month,
                            allowViewNavigation: false,
                            headerHeight: 50,
                            showNavigationArrow: true,
                            dataSource: MeetingDataSource(_getDataSource()),
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
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskTiles() {
    List<Widget> tiles = [];

    for (Task t in widget.tasks.tasks) {
      tiles.add(TaskTile(
        task: t,
        select: widget.select,
      ));
    }

    return tiles;
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];

    for (Task t in widget.tasks.tasks) {
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
}
