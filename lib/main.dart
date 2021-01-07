import 'dart:ui';

import 'package:flutter/material.dart';
import 'widgets/navbar.dart';
import 'utils/responsiveLayout.dart';

void main() => runApp(MaterialApp(
      title: 'PEPELIST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;
  @override
  void initState() {
    //Initialize the  scrollController

    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: <Widget>[
                    Body(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("wallpaper1.png"),
          )),
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBar(),
              SizedBox(
                height: 800,
                child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.expand,
                  children: <Widget>[
                    FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.5,
                      child: Image.asset("logo.png", scale: .85),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: .6,
                      child: Padding(
                        padding: EdgeInsets.only(left: 158),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Hello!",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat-Regular",
                                  color: Colors.white),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Welcome To ",
                                  style: TextStyle(
                                      fontSize: 60, color: Colors.white70),
                                  children: [
                                    TextSpan(
                                        text: "PEPELIST",
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[200]))
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, top: 20),
                              child: Text(
                                "LET’S EXPLORE THIS SITE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Container(
              color: Colors.red,
              height: size.height / 2.3,
              width: size.width / 1.5,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "WHAT IS PEPELIST?",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Flexible(
                      child: Container(
                        color: Colors.green,
                        child: Text(
                          "PEPELIST are a series of extremely useful resources to improve your productivity and organise your life. PEPELIST gives you more than just a to-do list,lanner & calendar app for managing and organizing your daily tasks, to-do lists, notes, reminders, checklists, calendar events, grocery lists, a place to write long notes, create organised outlines and track your daily routines. You can organize tasks by time period, including daily, weekly, monthly, long-term activities. This web app displays every activity through the dashboard so that every activity can be viewed and managed easily.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 25,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: size.height / 1.3,
          width: size.width,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "SERVICES",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height / 2,
                    width: size.width / 4,
                    color: Colors.amberAccent,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(
                                  "logo.png",
                                ),
                              ),
                            ),
                            height: size.height / 6.5,
                            width: size.width / 6.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("TODOLIST",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Flexible(
                            child: Container(
                              child: Text(
                                  "PEPELIST allows you to prioritize the tasks that are more important. This means you don’t waste time on tasks that don’t require your immediate attention. Your list will help you stay focused on the tasks that are the most important and provide a planner for managing and organizing your daily tasks such as checklists, grocery lists and more.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.3,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                   Container(
                    height: size.height / 2,
                    width: size.width / 4,
                    color: Colors.amberAccent,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(
                                  "logo.png",
                                ),
                              ),
                            ),
                            height: size.height / 6.5,
                            width: size.width / 6.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("TODOLIST",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Flexible(
                            child: Container(
                              child: Text(
                                  "PEPELIST allows you to prioritize the tasks that are more important. This means you don’t waste time on tasks that don’t require your immediate attention. Your list will help you stay focused on the tasks that are the most important and provide a planner for managing and organizing your daily tasks such as checklists, grocery lists and more.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.3,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                   Container(
                    height: size.height / 2,
                    width: size.width / 4,
                    color: Colors.amberAccent,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(
                                  "logo.png",
                                ),
                              ),
                            ),
                            height: size.height / 6.5,
                            width: size.width / 6.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("TODOLIST",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Flexible(
                            child: Container(
                              child: Text(
                                  "PEPELIST allows you to prioritize the tasks that are more important. This means you don’t waste time on tasks that don’t require your immediate attention. Your list will help you stay focused on the tasks that are the most important and provide a planner for managing and organizing your daily tasks such as checklists, grocery lists and more.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.3,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: size.height / 1.3,
          width: size.width,
          color: Colors.grey[200],
        ),
        SizedBox(
          height: 300,
        ),
      ],
    );
  }
}

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello!",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat-Regular"),
            ),
            RichText(
              text: TextSpan(
                text: 'Welcome To ',
                style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
                children: <TextSpan>[
                  TextSpan(
                      text: 'PEPeLIST',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black87)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text("LET’S EXPLORE THE WORLD"),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.network(
                "assets/images/student.png",
                scale: 1,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
