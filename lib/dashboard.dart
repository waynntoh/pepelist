import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';
import 'package:pepelist/performance.dart';
import 'package:pepelist/taskmanager.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String email;
  final String name;

  Dashboard({@required this.email, @required this.name});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool atManager = true;
  Task selectedTask;
  List rd = [];
  Data data = new Data();
  TextEditingController titleC = new TextEditingController();
  TextEditingController categoryC = new TextEditingController();
  TextEditingController sDateC = new TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              color: Color(0xff152238),
              height: size.height,
              width: size.width / 6,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .1,
                    color: Colors.grey[200],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Image.network(
                              'assets/images/logowhite.png',
                              scale: 3.5,
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            'PEPELIST',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      radius: 72,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent[700],
                        backgroundImage: NetworkImage('assets/images/user.png'),
                        radius: 70,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 80,
                    ),
                    //Dashboard
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          atManager = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.dashboard,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 26),
                          Text(
                            'Dashboard',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    //Performance
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          atManager = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add_chart,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 26),
                          Text(
                            'Performance',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 26),
                          Text(
                            'Sign out',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height,
              child: atManager
                  ? TaskManager(
                      data: data,
                      addTask: add,
                      editTask: edit,
                      deleteTask: delete,
                      select: selectTask,
                      selectedTask: selectedTask,
                      ownerEmail: widget.email,
                      resetSelectedTask: resetSelectedTask,
                      titleC: titleC,
                      categoryC: categoryC,
                      sdateC: sDateC,
                      resetCRUD: setCRUDControllers,
                      sortList: sortList,
                    )
                  : Performance(
                      tasks: data,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void add(Task t) {
    setState(() {
      data.tasks.add(t);
    });
  }

  void edit(Task t, String title, String category, DateTime dd) {
    setState(() {
      for (Task task in data.tasks) {
        if (task.dateCreated == t.dateCreated) {
          task.editTask(title, category, dd);
        }
      }
    });
  }

  void delete(Task t) {
    setState(() {
      data.tasks.remove(t);
    });
  }

  void selectTask(Task t) {
    setState(() {
      selectedTask = t;
    });
  }

  void resetSelectedTask() {
    setState(() {
      selectedTask = null;
    });
  }

  void getData() {
    http.post('https://techvestigate.com/pepelist/php/getTask.php', body: {
      "owneremail": widget.email,
    }).then((res) {
      if (res.body != 'failed') {
        var extractdata = json.decode(res.body);
        rd = extractdata["tasks"];

        for (int i = 0; i < rd.length; i++) {
          DateTime dc = DateTime.parse(rd[i]['datecreated']);
          DateTime dd = DateTime.parse(rd[i]['duedate']);
          bool completed = rd[i]['completed'] == '0' ? false : true;

          Task newTask = new Task(widget.email, rd[i]['title'],
              rd[i]['category'], dc, dd, completed);

          data.tasks.add(newTask);
        }
        sortList();
      } else {
        print('[-] Get tasks failed');
      }
    }).catchError((err) {
      print(err);
    });
  }

  void setCRUDControllers() {
    setState(() {
      titleC.text = selectedTask.title;
      categoryC.text = selectedTask.category;
      sDateC.text = selectedTask.dueDate.toString();
    });
  }

  void sortList() {
    setState(() {
      // Sort data according to date
      data.tasks.sort(
        (Task a, Task b) => b.dateCreated.compareTo(a.dateCreated),
      );
    });
  }
}
