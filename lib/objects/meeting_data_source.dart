import 'package:flutter/material.dart';
import 'package:pepelist/objects/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].dueDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].dueDate;
  }

  @override
  String getSubject(int index) {
    return appointments[index].title;
  }

  @override
  Color getColor(int index) {
    return appointments[index].color;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}
