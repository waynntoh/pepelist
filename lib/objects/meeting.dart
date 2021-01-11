import 'package:flutter/material.dart';

class Meeting {
  String title;
  String category;
  DateTime dueDate;
  Color color;
  bool isAllDay;

  Meeting({this.title, this.category, this.dueDate}) {
    switch (category) {
      case 'Personal':
        this.color = Colors.blueAccent;
        break;
      case 'Groceries':
        this.color = Colors.green;
        break;
      case 'Work':
        this.color = Colors.teal;
        break;
      case 'School':
        this.color = Colors.purpleAccent;
        break;
      case 'Home':
        this.color = Colors.orangeAccent;
        break;
      case 'Other':
        this.color = Colors.pinkAccent;
        break;
    }
    isAllDay = true;
  }
}
