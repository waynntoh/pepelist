import 'package:flutter/material.dart';
import 'package:pepelist/utils/responsiveLayout.dart';
import 'package:pepelist/widgets/navbar.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        DashBoardBody(),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

class DashBoardBody extends StatefulWidget {
  @override
  _DashBoardBodyState createState() => _DashBoardBodyState();
}

class _DashBoardBodyState extends State<DashBoardBody> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeDash(),
      mediumScreen: MediumDash(),
      smallScreen: SmallDash(),
    );
  }
}

class LargeDash extends StatefulWidget {
  const LargeDash({Key key}) : super(key: key);

  @override
  _LargeDashState createState() => _LargeDashState();
}

class _LargeDashState extends State<LargeDash> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      width: data.size.width / 20,
      height: data.size.height,
      decoration: BoxDecoration(color: Colors.blue[100]),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Image.network(
              "assets/images/Logo.png",
              scale: 3,
            ),
          ),
          SizedBox(height: 50,),
          NavBars(),
        ],
      ),
    );
  }
}

class MediumDash extends StatelessWidget {
  const MediumDash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class SmallDash extends StatelessWidget {
  const SmallDash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

class NavBars extends StatefulWidget {
  NavBars({Key key}) : super(key: key);

  @override
  _NavBarsState createState() => _NavBarsState();
}

class _NavBarsState extends State<NavBars> {
  List<bool> selected = [true, false, false, false, false];
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NavbBarItem(
            active: selected[0],
            icon: Icons.home,
            touch: () {
              setState(() {
                select(0);
              });
            },
          ),
        ],
      ),
    );
  }
}

class NavbBarItem extends StatefulWidget {
  final IconData icon;
  final Function touch;
  final bool active;

  NavbBarItem({
    this.active,
    this.icon,
    this.touch,
  });

  @override
  _NavbBarItemState createState() => _NavbBarItemState();
}

class _NavbBarItemState extends State<NavbBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.touch();
        },
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 475),
                      height: 35,
                      width: 5,
                      decoration: BoxDecoration(
                          color:
                              widget.active ? Colors.black54 : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Icon(
                        widget.icon,
                        color: widget.active ? Colors.black : Colors.black54 ,
                        size: 24,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
