import 'package:flutter/material.dart';
import 'package:pepelist/performance.dart';
import 'package:pepelist/taskmanager.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool atManager = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            SizedBox(
              height: size.height,
              width: size.width / 5,
              child: Container(
                padding: EdgeInsets.all(32),
                color: Colors.blue[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('logo.png'),
                      radius: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'GUEST USER',
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          atManager = true;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.dashboard,
                            size: 100,
                          ),
                          Text('Dashboard'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          atManager = false;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_chart,
                            size: 100,
                          ),
                          Text('Performance'),
                        ],
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        print('Sign out');
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            size: 100,
                          ),
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
              child: atManager ? TaskManager() : Performance(),
            ),
          ],
        ),
      ),
    );
  }
}
