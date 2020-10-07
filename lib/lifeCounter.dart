import 'dart:async';
import 'package:flutter/material.dart';
import './lifeGain.dart';
import './colorPicker.dart';
import './playerStats.dart';
import './colorSelection.dart';

class LifeCounter extends StatefulWidget {
  final bool upSideDown;
  final bool portraitMode;
  final PlayerStats player;
  final Function(int, PlayerStats) setHealthHandler;
  final bool useCardLayout;

  LifeCounter({
    this.upSideDown = false,
    this.portraitMode = false,
    @required this.player,
    @required this.setHealthHandler,
    @required this.useCardLayout,
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

  getCardBorderRadius() {
    return widget.useCardLayout
        ? new BorderRadius.all(
            new Radius.circular(16.0),
          )
        : new BorderRadius.all(Radius.zero);
  }

  Decoration getLifeCounterContainerDecoration() {
    var image = usedColor.image;
    if (image != null) {
      return BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: getCardBorderRadius(),
      );
    } else {
      return BoxDecoration(
        color: usedColor.color1,
        borderRadius: getCardBorderRadius(),
      );
    }
  }

  Shadow textShadow = Shadow(
    blurRadius: 2,
    color: Colors.black,
    offset: Offset.fromDirection(0.25),
  );

  setHealth(int healthMultiplier, PlayerStats player) {
    setLifeGain(healthMultiplier);
    widget.setHealthHandler(healthMultiplier, widget.player);
  }

  // Life gain debounce logic TODO: move this to a separate file
  int lifeGain = 0;
  bool isLifeGainVisible = false;
  Timer _setLifeGainDebounce;
  Timer _resetLifeGainDebounce;
  static Duration _timerSetLifeGainDuration =
      Duration(seconds: 1, milliseconds: 500);

  static Duration _timerResetLifeGainDuration = Duration(milliseconds: 400);

  resetLifeGain() {
    this.setState(() {
      isLifeGainVisible = false;
    });
    _resetLifeGainDebounce = Timer(_timerResetLifeGainDuration, () {
      this.setState(() {
        lifeGain = 0;
      });
    });
  }

  setLifeGain(int amount) {
    if (_resetLifeGainDebounce?.isActive ?? false)
      _resetLifeGainDebounce.cancel();
    if (_setLifeGainDebounce?.isActive ?? false) _setLifeGainDebounce.cancel();

    _setLifeGainDebounce = Timer(_timerSetLifeGainDuration, () {
      resetLifeGain();
    });

    this.setState(() {
      lifeGain += amount;
      isLifeGainVisible = true;
    });
  }

  Widget getSetHealthButton(String text, int healthMultiplier) =>
      RawMaterialButton(
        onPressed: () => setHealth(healthMultiplier, widget.player),
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
          margin: widget.useCardLayout ? EdgeInsets.all(4.0) : EdgeInsets.zero,
          shadowColor: widget.useCardLayout ? Colors.black : Colors.transparent,
          elevation: widget.useCardLayout ? 2 : 0,
          shape: RoundedRectangleBorder(borderRadius: getCardBorderRadius()),
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Text(
                          widget.player.life.toString(),
                          style: TextStyle(
                            shadows: [textShadow],
                            fontSize: 64,
                            color: widget.player.life > 0
                                ? usedColor.textColor
                                : Colors.red,
                          ),
                        ),
                        LifeGain(
                          lifeChange: lifeGain,
                          visible: isLifeGainVisible,
                          textStyle: TextStyle(
                              shadows: [textShadow],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: usedColor.textColor),
                        ),
                      ],
                    )),
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
