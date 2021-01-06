import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';
import 'package:pepelist/performance.dart';
import 'package:pepelist/taskmanager.dart';

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

  // TODO: Delete
  Data data = new Data();

  @override
  void initState() {
    // TODO: get data from database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            SizedBox(
              height: size.height,
              width: size.width / 6,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .1,
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PEPELIST',
                          style: TextStyle(fontSize: 28),
                        ),
                        SizedBox(width: 18),
                        Image.asset(
                          'logo.png',
                          scale: 3,
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    CircleAvatar(
                      backgroundImage: AssetImage('harold.jpg'),
                      radius: 75,
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.email,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //Dashboard
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue[100],
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
                            color: Colors.lightBlue[900],
                          ),
                          SizedBox(width: 16),
                          Text('Dashboard'),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue[100],
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
                            color: Colors.lightBlue[900],
                          ),
                          SizedBox(width: 16),
                          Text('Performance'),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue[100],
                      onPressed: () {
                        print('Sign out');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 40,
                            color: Colors.lightBlue[900],
                          ),
                          SizedBox(width: 16),
                          Text('Sign out'),
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
        if (task.title == t.title) {
          task.editTask(title, category, dd);
        }
      }
    });
  }

  void delete(Task t) {
    setState(() {
      data.tasks.remove(t);
      print('removed');
    });
  }

  void selectTask(Task t) {
    setState(() {
      selectedTask = t;
    });
  }
}
