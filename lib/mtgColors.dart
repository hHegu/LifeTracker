import 'dart:ui';

class MtgColor {
  final Color secondaryColor;
  final Color mainColor;
  const MtgColor({this.secondaryColor, this.mainColor});
}

class MtgColors {
  static const red = const MtgColor(
    secondaryColor: Color.fromARGB(255, 235, 159, 130),
    mainColor: Color.fromARGB(255, 211, 32, 42),
  );
  static const green = const MtgColor(
    secondaryColor: Color.fromARGB(255, 196, 211, 202),
    mainColor: Color.fromARGB(255, 0, 115, 62),
  );
  static const blue = const MtgColor(
    secondaryColor: Color.fromARGB(255, 179, 206, 234),
    mainColor: Color.fromARGB(255, 14, 104, 171),
  );
  static const black = const MtgColor(
    secondaryColor: Color.fromARGB(255, 166, 159, 157),
    mainColor: Color.fromARGB(255, 21, 11, 0),
  );
  static const white = const MtgColor(
    secondaryColor: Color.fromARGB(255, 248, 231, 185),
    mainColor: Color.fromARGB(255, 249, 250, 244),
  );
}
