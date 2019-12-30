import 'package:flutter/material.dart';
import 'package:life_counter_app/mtgColors.dart';
import 'dart:math';
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

  static Map<String, List<ColorSelection>> colors = {
    'Basic': [
      ColorSelection(
        textColor: Colors.black,
        color1: Colors.white,
      ),
      ColorSelection(
        textColor: MtgColors.black.mainColor,
        color1: MtgColors.black.secondaryColor,
      ),
      ColorSelection(
        textColor: Colors.black,
        color1: MtgColors.white.secondaryColor,
      ),
      ColorSelection(
        textColor: MtgColors.red.mainColor,
        color1: MtgColors.red.secondaryColor,
      ),
      ColorSelection(
        textColor: MtgColors.blue.mainColor,
        color1: MtgColors.blue.secondaryColor,
      ),
      ColorSelection(
        textColor: MtgColors.green.mainColor,
        color1: MtgColors.green.secondaryColor,
      ),
    ],
    'Multi': [
      ColorSelection(
        textColor: Colors.white,
        color1: MtgColors.red.mainColor,
        color2: MtgColors.blue.mainColor,
        image: 'assets/Izzetlogo.png'
      )
    ]
  };

  static final colorPickerPadding = 10.0;
  static final colorSelectionSize = 56.0;
  static final colorSelectionTitleWidth = 50.0;
  static final colorSelectionTitlePadding = 6.0;
  static final colorPickerWidth = colors.values
              .map((colorList) => colorList.length)
              .reduce(max)
              .toDouble() *
          colorSelectionSize -
      colorPickerPadding * 2.0 +
      colorSelectionTitleWidth;

  void selectColor(ColorSelection color) {}

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
              padding: EdgeInsets.all(colorPickerPadding),
              // Width of one color selection element is 56px
              width: open ? colorPickerWidth : 0,
              child: Container(
                height: colors.values.length * colorSelectionSize - 8,
                child: Card(
                    elevation: 6,
                    child: Column(
                        children: colors.entries
                            .map(
                              (colorCategory) => Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: colorSelectionTitlePadding,
                                    ),
                                    width: colorSelectionTitleWidth,
                                    child: Text(
                                      colorCategory.key,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ...colorCategory.value
                                      .map((color) => ColorPickerSelection(
                                          color: color,
                                          onPressed: () {
                                            setState(() {
                                              widget.selectColorHandler(color);
                                              open = !open;
                                            });
                                          }))
                                      .toList(),
                                ],
                              ),
                            )
                            .toList())),
              ))
        ],
      ),
    );
  }
}

class ColorPickerSelection extends StatelessWidget {
  final ColorSelection color;
  final Function onPressed;

  ColorPickerSelection({this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var decoration = color.color2 != null
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: [color.color1, color.color2],
            ),
          )
        : BoxDecoration(
            color: color.color1,
          );
    return Container(
      decoration: decoration,
      child: IconButton(
        icon: Icon(Icons.texture),
        color: color.textColor,
        onPressed: onPressed,
      ),
    );
  }
}
