import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor themeColor = MaterialColor( 
    // 0xff3f51b5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    0xff5c6bc0,
    <int, Color>{ 
      50: const Color(0xff5360ad),//10% 
      100: const Color(0xff4a569a),//20% 
      200: const Color(0xff404b86),//30% 
      300: const Color(0xff374073),//40% 
      400: const Color(0xff2e3660),//50% 
      500: const Color(0xff252b4d),//60% 
      600: const Color(0xff1c203a),//70% 
      700: const Color(0xff121526),//80% 
      800: const Color(0xff090b13),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  ); 
}