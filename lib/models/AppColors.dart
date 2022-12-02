import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFF000000;

  static MaterialColor richBlack = MaterialColor( const Color.fromRGBO(0, 23, 31, 1).value,  const <int, Color>{
    50: Color.fromRGBO(0, 23, 31, 0.1),
    100: Color.fromRGBO(0, 23, 31,  0.2),
    200: Color.fromRGBO(0, 23, 31, 0.3),
    300: Color.fromRGBO(0, 23, 31,  0.4),
    400: Color.fromRGBO(0, 23, 31,  0.5),
    500: Color.fromRGBO(40, 23, 31,0.6),
    600: Color.fromRGBO(0, 23, 31,0.7),
    700: Color.fromRGBO(0, 23, 31,0.8),
    800: Color.fromRGBO(0, 23, 31,0.9),
    900: Color.fromRGBO(0, 23, 31,1),
  },
  );
  static MaterialColor prussianBlue = MaterialColor( const Color.fromRGBO(0, 52, 89, 1).value,  const <int, Color>{
    50: Color.fromRGBO(0, 52, 89, 0.1),
    100: Color.fromRGBO(0, 52, 89,  0.2),
    200: Color.fromRGBO(0, 52, 89, 0.3),
    300: Color.fromRGBO(0, 52, 89,  0.4),
    400: Color.fromRGBO(0, 52, 89,  0.5),
    500: Color.fromRGBO(0, 52, 89,0.6),
    600: Color.fromRGBO(0, 52, 89,0.7),
    700: Color.fromRGBO(0, 52, 89,0.8),
    800: Color.fromRGBO(0, 52, 89,0.9),
    900: Color.fromRGBO(0, 52, 89,1),
  },
  );
  static MaterialColor celadonBlue = MaterialColor( const Color.fromRGBO(0, 126, 167, 1).value,  const <int, Color>{
    50: Color.fromRGBO(0, 126, 167, 0.1),
    100: Color.fromRGBO(0, 126, 167,  0.2),
    200: Color.fromRGBO(0, 126, 167, 0.3),
    300: Color.fromRGBO(0, 126, 167,  0.4),
    400: Color.fromRGBO(0, 126, 167,  0.5),
    500: Color.fromRGBO(0, 126, 167,0.6),
    600: Color.fromRGBO(0, 126, 167,0.7),
    700: Color.fromRGBO(0, 126, 167,0.8),
    800: Color.fromRGBO(0, 126, 167,0.9),
    900: Color.fromRGBO(0, 126, 167,1),
  },
  );
  static MaterialColor carolinaBlue = MaterialColor( const Color.fromRGBO(0, 168, 232, 1).value,  const <int, Color>{
    50: Color.fromRGBO(0, 168, 232, 0.1),
    100: Color.fromRGBO(0, 168, 232,  0.2),
    200: Color.fromRGBO(0, 168, 232, 0.3),
    300: Color.fromRGBO(0, 168, 232,  0.4),
    400: Color.fromRGBO(0, 168, 232,  0.5),
    500: Color.fromRGBO(0, 168, 232,0.6),
    600: Color.fromRGBO(0, 168, 232,0.7),
    700: Color.fromRGBO(0, 168, 232,0.8),
    800: Color.fromRGBO(0, 168, 232,0.9),
    900: Color.fromRGBO(0, 168, 232,1),
  },
  );

}