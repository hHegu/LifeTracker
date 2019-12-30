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
    color1: Colors.white,
  );

  void changeColor(ColorSelection color) {
    setState(() {
      this.usedColor = color;
    });
  }

  Decoration getLifeCounterContainerDecoration() {
    var image = usedColor.image;
    if (image != null) {
      return BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: new BorderRadius.all(
          new Radius.circular(3.0),
        ),
      );
    } else {
      return BoxDecoration(color: usedColor.color1);
    }
  }

  Shadow textShadow = Shadow(
    blurRadius: 2,
    color: Colors.black,
    offset: Offset.fromDirection(0.25),
  );

  Widget getSetHealthButton(String text, int healthMultiplier) =>
      RawMaterialButton(
        onPressed: () => widget.setHealthHandler(healthMultiplier, widget.player),
        padding: EdgeInsets.all(40),
        shape: CircleBorder(),
        child: Text(
          text,
          style: TextStyle(
            shadows: [textShadow],
            fontSize: 50,
            color: widget.player.life > 0 ? usedColor.textColor : Colors.red,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.portraitMode
          ? (widget.upSideDown ? 0 : 2)
          : (widget.upSideDown ? 1 : 3),
      child: Stack(children: <Widget>[
        Card(
          child: Container(
            decoration: getLifeCounterContainerDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getSetHealthButton('-', -1),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 130,
                  alignment: Alignment.center,
                  child: Text(
                    widget.player.life.toString(),
                    style: TextStyle(
                      shadows: [textShadow],
                      fontSize: 64,
                      color: widget.player.life > 0
                          ? usedColor.textColor
                          : Colors.red,
                    ),
                  ),
                ),
                getSetHealthButton('+', 1),
              ],
            ),
          ),
        ),
        ColorPicker(selectedColor: usedColor, selectColorHandler: changeColor)
      ]),
    );
  }
}
