import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pepelist/objects/task.dart';

class TotalTaskLineChart extends StatefulWidget {
  final Data tasks;
  TotalTaskLineChart({@required this.tasks});
  @override
  _TotalTaskLineChartState createState() => _TotalTaskLineChartState();
}

class _TotalTaskLineChartState extends State<TotalTaskLineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  bool showAvg = false;
  double january = 0;
  double febuary = 0;
  double december = 0;

  @override
  void initState() {
    for (int i = 0; i < widget.tasks.tasks.length; i++) {
      if (widget.tasks.tasks[i].dateCreated.month == 01) {
        january = january + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 02) {
        febuary = febuary + 1;
      }
      if (widget.tasks.tasks[i].dateCreated.month == 12) {
        december =december + 1;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 40, bottom: 12),
            child: LineChart(
            mainData(),
            ),
          ),
        ),
      
        Align(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total Task",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
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
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 2,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, december),
            FlSpot(1, january),
            FlSpot(2, febuary),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  


}
