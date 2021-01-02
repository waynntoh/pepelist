import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pepelist/charts/montlyBarChart.dart';
import 'package:pepelist/charts/progressLineChart.dart';
import 'package:pepelist/charts/totalTaskLineChart.dart';
import 'package:pepelist/charts/weeklyBarChart.dart';

class Performance extends StatefulWidget {
  Performance({Key key}) : super(key: key);

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200]
      ),
      height: size.height,
      width: size.width - size.width / 6,
      child: Row(
        children: [
          SizedBox(
            width: 100,
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.indigo[100], Colors.cyan[600]]),
                      ),
                      height: 250,
                      width: 350,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "100",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Total Task",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.purple[100], Colors.purple[600]]),
                      ),
                       child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("32",style: TextStyle(
                                color: Colors.purple[800],
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                              ),),
                            ),

                            Text("Upcoming Task",style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),)
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue[100], Colors.blue[400]]),
                      ),
                       child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("56",style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                              ),),
                            ),

                            Text("Completed Task",style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),)
                            
                          ],
                        ),
                      ),
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.red[100], Colors.red[400]]),
                      ),
                       child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("16",style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                              ),),
                            ),

                            Text("Overdue Task",style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),)
                            
                          ],
                        ),
                      ),
                    ),
                    
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 260,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: MonthlyBarChart(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 260,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: WeeklyBarChart(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                height: 400,
                width: 600,
                child: ProgressLineChart(),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TotalTaskLineChart(),
                height: 400,
                width: 600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
