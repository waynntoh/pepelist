import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';

class ProgressLineChart extends StatefulWidget {
  final Data tasks;

  ProgressLineChart({@required this.tasks});
  @override
  _ProgressLineChartState createState() => _ProgressLineChartState();
}

class _ProgressLineChartState extends State<ProgressLineChart> {
  bool isShowingMainData;
  double completedTasksDec = 0;
  double overdueTasksDec = 0;
  double upcomingTasksDec = 0;
  double completedTasksJan = 0;
  double overdueTasksJan = 0;
  double upcomingTasksJan = 0;
  double completedTasksFeb = 0;
  double overdueTasksFeb = 0;
  double upcomingTasksFeb = 0;
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;

    for (int i = 0; i < widget.tasks.tasks.length; i++) {
      //Dec Task
      if (widget.tasks.tasks[i].dateCreated.month == 12) {
        if (widget.tasks.tasks[i].completed == true) {
          completedTasksDec = completedTasksDec + 1;
        } else if (DateTime.now().isAfter(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          overdueTasksDec = overdueTasksDec + 1;
        } else if (DateTime.now().isBefore(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          upcomingTasksDec = upcomingTasksDec + 1;
        }
      }
      //Jan
      if (widget.tasks.tasks[i].dateCreated.month == 01) {
        if (widget.tasks.tasks[i].completed == true) {
          completedTasksJan = completedTasksJan + 1;
        } else if (DateTime.now().isAfter(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          overdueTasksJan = overdueTasksJan + 1;
        } else if (DateTime.now().isBefore(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          upcomingTasksJan = upcomingTasksJan + 1;
        }
      }
      //Feb
      if (widget.tasks.tasks[i].dateCreated.month == 02) {
        if (widget.tasks.tasks[i].completed == true) {
          completedTasksFeb = completedTasksFeb + 1;
        } else if (DateTime.now().isAfter(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          overdueTasksFeb = overdueTasksFeb + 1;
        } else if (DateTime.now().isBefore(widget.tasks.tasks[i].dueDate) &&
            !widget.tasks.tasks[i].completed) {
          upcomingTasksFeb = upcomingTasksFeb + 1;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Task Progress',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'DEC';
              case 1:
                return 'JAN';
              case 2:
                return 'FEB';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 2,
      maxY: 30,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        //OVERDUE
        FlSpot(0, overdueTasksDec),
        FlSpot(1, overdueTasksJan),
        FlSpot(2, overdueTasksFeb),
      ],
      isCurved: true,
      colors: [
        const Color(0xFFE57373),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        //UPCOMING TASK
        FlSpot(0, upcomingTasksDec),
        FlSpot(1, upcomingTasksJan),
        FlSpot(2, upcomingTasksFeb),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        //COMPLETED TASK
        FlSpot(0, completedTasksDec),
        FlSpot(1, completedTasksJan),
        FlSpot(2, completedTasksFeb),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
    ];
  }
}
