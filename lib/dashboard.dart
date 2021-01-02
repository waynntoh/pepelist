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
              width: size.width / 6,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue[100],
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
                      radius: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'HAROLD PAIN',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'hidethepainharold@gmail.com',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //Dashboard
                    FlatButton(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue[200],
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
                      color: Colors.blue[200],
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
                      color: Colors.blue[200],
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
              child: atManager ? TaskManager() : Performance(),
            ),
          ],
        ),
      ),
    );
  }
}
