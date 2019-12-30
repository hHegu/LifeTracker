import 'package:flutter/material.dart';
import './colorPicker.dart';
import './playerStats.dart';
import './colorSelection.dart';

class LifeCounter extends StatefulWidget {
  final bool upSideDown;
  final bool portraitMode;
  final PlayerStats player;
  final Function(int, PlayerStats) setHealthHandler;

  LifeCounter({
    this.upSideDown = false,
    this.portraitMode = false,
    @required this.player,
    @required this.setHealthHandler,
  });

  @override
  _LifeCounterState createState() => _LifeCounterState();
}

class _LifeCounterState extends State<LifeCounter> {
  ColorSelection usedColor = ColorSelection(
    textColor: Colors.black,
    backgroundColor: Colors.white,
  );

  void changeColor(ColorSelection color) {
    setState(() {
      this.usedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.portraitMode
          ? (widget.upSideDown ? 0 : 2)
          : (widget.upSideDown ? 1 : 3),
      child: Stack(children: <Widget>[
        Card(
          color: usedColor.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                iconSize: 40,
                color: usedColor.textColor,
                padding: EdgeInsets.all(40),
                onPressed: () => widget.setHealthHandler(-1, widget.player),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  widget.player.life.toString(),
                  style: TextStyle(
                      fontSize: 64,
                      color: widget.player.life > 0
                          ? usedColor.textColor
                          : Colors.red),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: usedColor.textColor,
                onPressed: () => widget.setHealthHandler(1, widget.player),
                padding: EdgeInsets.all(40),
                iconSize: 40,
              ),
            ],
          ),
        ),
        ColorPicker(selectedColor: usedColor, selectColorHandler: changeColor)
      ]),
    );
  }
}
