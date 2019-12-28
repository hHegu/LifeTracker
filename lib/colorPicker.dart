import 'package:flutter/material.dart';
import 'package:life_counter_app/mtgColors.dart';
import './colorSelection.dart';

class ColorPicker extends StatefulWidget {
  ColorSelection selectedColor;
  Function(ColorSelection) selectColorHandler;

  ColorPicker({this.selectedColor, this.selectColorHandler});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  bool open = false;

  List<ColorSelection> basicColors = [
    ColorSelection(
      textColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    ColorSelection(
      textColor: MtgColors.black.mainColor,
      backgroundColor: MtgColors.black.secondaryColor,
    ),
    ColorSelection(
      textColor: Colors.black,
      backgroundColor: MtgColors.white.secondaryColor,
    ),
    ColorSelection(
      textColor: MtgColors.red.mainColor,
      backgroundColor: MtgColors.red.secondaryColor,
    ),
    ColorSelection(
      textColor: MtgColors.blue.mainColor,
      backgroundColor: MtgColors.blue.secondaryColor,
    ),
    ColorSelection(
      textColor: MtgColors.green.mainColor,
      backgroundColor: MtgColors.green.secondaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          IconButton(
            icon: Icon(Icons.color_lens),
            color: widget.selectedColor.textColor,
            onPressed: () {
              setState(() {
                open = !open;
              });
            },
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeIn,
              padding: EdgeInsets.all(10),
              // Width of one color selection element is 56px
              width: open ? basicColors.length * 56.0 - 20 : 0,
              child: Container(
                height: 56,
                child: Card(
                    elevation: 6,
                    child: Column(
                      children: <Widget>[
                        // Text('Basic colors'),
                        Row(
                          children: basicColors
                              .map(
                                (color) => Container(
                                  decoration: new BoxDecoration(
                                    color: color.backgroundColor,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.brightness_1),
                                    color: color.textColor,
                                    onPressed: () {
                                      setState(() {
                                        widget.selectColorHandler(color);
                                        open = !open;
                                      });
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    )),
              ))
        ],
      ),
    );
  }
}
