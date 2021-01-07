import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pepelist/dashboard.dart';
import 'package:pepelist/login.dart';
import 'package:pepelist/performance.dart';
import 'package:pepelist/register.dart';
import 'widgets/navbar.dart';
import 'utils/responsiveLayout.dart';

void main() => runApp(MaterialApp(
      title: 'PEPELIST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.arvoTextTheme(),
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
        Container(
          height: 300,
          width: 300,
          color: Colors.black,
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
