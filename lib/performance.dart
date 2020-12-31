import 'package:flutter/material.dart';

class Performance extends StatefulWidget {
  Performance({Key key}) : super(key: key);

  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
       child:Container(
         color: Colors.blue,
         child: Row(children: [
           Container(
             child: Column(
               children: [
                 
               ],
             ),
           ),
         ],),
       ),
    );
  }
}