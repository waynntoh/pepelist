import 'package:flutter/material.dart';

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
      color: Colors.blue,
      height: size.height,
      width: size.width - size.width / 5,
<<<<<<< HEAD
=======
      child: Center(
        child: Text('Performance'),
      ),
>>>>>>> 6699519b68857476075088795e8fc24d716d3c72
    );
  }
}
