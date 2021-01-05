import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pepelist/charts/montlyBarChart.dart';
import 'package:pepelist/charts/progressLineChart.dart';
import 'package:pepelist/charts/totalTaskLineChart.dart';
import 'package:pepelist/charts/weeklyBarChart.dart';
import 'package:pepelist/objects/task.dart';

class Performance extends StatefulWidget {
  final Tasks tasks;

  Performance({@required this.tasks});

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  int totalTasks=0;
  int completedTasks=0;
  int overdueTasks=0;
  int upcomingTasks=0;

  @override
  void initState() {
    totalTasks = widget.tasks.tasks.length;

  for(int i=0; i<widget.tasks.tasks.length; i++){
    if(widget.tasks.tasks[i].completed == true){
      completedTasks=completedTasks+1;
    }
    if(DateTime.now().isAfter(widget.tasks.tasks[i].dueDate) && !widget.tasks.tasks[i].completed){
      overdueTasks=overdueTasks+1;
    }
    if(DateTime.now().isBefore(widget.tasks.tasks[i].dueDate) && !widget.tasks.tasks[i].completed){
     upcomingTasks=upcomingTasks+1;
    }
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      padding: EdgeInsets.all(32),
      height: size.height,
      width: size.width - size.width / 6,
      child: Row(
        children: [
          Column(
            children: [
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
                      height: size.height / 4.2,
                      width: size.width / 5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //totaltask
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                totaltask(),
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
                      height: size.height / 4.2,
                      width: size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.purple[100], Colors.purple[600]]),
                      ),
                      child: Center(
                        //Upcomingtask
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                upcomingtask(),
                                style: TextStyle(
                                    color: Colors.purple[800],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Upcoming Task",
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
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: size.height / 4.2,
                      width: size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.blue[100], Colors.blue[400]]),
                      ),
                      child: Center(
                        //Completed Task
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                completedTask(),
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Completed Task",
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
                      height: size.height / 4.2,
                      width: size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.red[100], Colors.red[400]]),
                      ),
                      child: Center(
                        //OverdueTask
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                overdueTask(),
                                style: TextStyle(
                                    color: Colors.red[800],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Overdue Task",
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
                ],
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: size.height / 3.4,
                      width: size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: MonthlyBarChart(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: size.height / 3.4,
                      width: size.width / 5,
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
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: size.height / 2.4,
                  width: size.width / 3.2,
                  child: ProgressLineChart(tasks: widget.tasks,),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: TotalTaskLineChart(tasks: widget.tasks,),
                  height: size.height / 2.4,
                  width: size.width / 3.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String totaltask() {
    String total = "$totalTasks";
    return total;
  }

  String upcomingtask() {
    String total = "$upcomingTasks";
    return total;
  }

  String completedTask() {
    String total = "$completedTasks";
    return total;
  }

  String overdueTask() {
    String total = "$overdueTasks";
    return total;
  }
}
