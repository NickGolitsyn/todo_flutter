import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor themeColor = MaterialColor(
    // 0xff3f51b5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    // 0xff5c6bc0,
    0xff3f51b5,
    <int, Color>{
      50: Color(0xff3949a3), //10%
      100: Color(0xff324191), //20%
      200: Color(0xff2c397f), //30%
      300: Color(0xff26316d), //40%
      400: Color(0xff20295b), //50%
      500: Color(0xff192048), //60%
      600: Color(0xff131836), //70%
      700: Color(0xff0d1024), //80%
      800: Color(0xff060812), //90%
      900: Color(0xff000000), //100%
    },
  );
}
