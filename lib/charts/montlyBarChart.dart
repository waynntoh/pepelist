import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:pepelist/objects/task.dart';

class MonthlyBarChart extends StatefulWidget {
  final Data tasks;

  MonthlyBarChart({@required this.tasks});
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  _MonthlyBarChartState createState() => _MonthlyBarChartState();
}

class _MonthlyBarChartState extends State<MonthlyBarChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;
  bool isPlaying = false;
  double totaltaskJan = 0.0;
  double totaltaskFeb = 0.0;
  double totaltaskMar = 0.0;
  double totaltaskApr = 0.0;
  double totaltaskMay = 0.0;
  double totaltaskJun = 0.0;
  double totaltaskJul = 0.0;
  double totaltaskAug = 0.0;
  double totaltaskSep = 0.0;
  double totaltaskOgs = 0.0;
  double totaltaskNov = 0.0;
  double totaltaskDec = 0.0;

  @override
  void initState() {
    for (int i = 0; i < widget.tasks.tasks.length; i++) {
      if (widget.tasks.tasks[i].dateCreated.month == 01) {
        totaltaskJan = totaltaskJan + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 02) {
        totaltaskFeb = totaltaskFeb + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 03) {
        totaltaskMar = totaltaskMar + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 04) {
        totaltaskApr = totaltaskApr + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 05) {
        totaltaskMay = totaltaskMay + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 06) {
        totaltaskJun = totaltaskJun + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 07) {
        totaltaskJul = totaltaskJul + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 08) {
        totaltaskAug = totaltaskAug + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 09) {
        totaltaskSep = totaltaskSep + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 10) {
        totaltaskOgs = totaltaskOgs + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 11) {
        totaltaskNov = totaltaskNov + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 12 &&
          widget.tasks.tasks[i].dateCreated.year == 2021) {
        totaltaskDec = totaltaskDec + 1;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.blueGrey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Monthly Task',
                            style: TextStyle(
                                color: const Color(0xff0f4a3c),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Task Done In A Month',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, totaltaskJan, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, totaltaskFeb, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, totaltaskMar, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, totaltaskApr, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, totaltaskMay, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, totaltaskJun, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, totaltaskJul, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, totaltaskAug, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, totaltaskSep, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, totaltaskOgs, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, totaltaskNov,
                isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, totaltaskDec,
                isTouched: i == touchedIndex);

          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'January';
                  break;
                case 1:
                  weekDay = 'February';
                  break;
                case 2:
                  weekDay = 'March';
                  break;
                case 3:
                  weekDay = 'April';
                  break;
                case 4:
                  weekDay = 'May';
                  break;
                case 5:
                  weekDay = 'June';
                  break;
                case 6:
                  weekDay = 'July';
                  break;
                case 7:
                  weekDay = 'August';
                  break;
                case 8:
                  weekDay = 'September';
                  break;
                case 9:
                  weekDay = 'Octorber';
                  break;
                case 10:
                  weekDay = 'November';
                  break;
                case 11:
                  weekDay = 'December';
                  break;

                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'J';
              case 1:
                return 'F';
              case 2:
                return 'M';
              case 3:
                return 'A';
              case 4:
                return 'M';
              case 5:
                return 'J';
              case 6:
                return 'J';
              case 7:
                return 'A';
              case 8:
                return 'S';
              case 9:
                return 'O';
              case 10:
                return 'N';
              case 11:
                return 'D';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
