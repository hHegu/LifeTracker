import 'package:flutter/material.dart';

class LifeGain extends StatelessWidget {
  int lifeChange = 0;
  bool visible = false;
  TextStyle textStyle;

  LifeGain({this.lifeChange, this.visible, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: visible ? 92 : 40),
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Duration(milliseconds: 400),
        child: Text(
          "${lifeChange > 0 ? '+' : ''}${lifeChange.toString()}",
          style: textStyle,
        ),
      ),
      duration: Duration(milliseconds: 400),
      curve: Curves.decelerate,
    );
  }
}
