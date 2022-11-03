import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: const Color(0xFF2A2D3E),//Color(0xFF2697FF),
        //secondaryColor: Color(0xFF2A2D3E),
      hoverColor: Colors.white60,
      scaffoldBackgroundColor: const Color(0xFF212332),
      canvasColor: const Color(0xFF2A2D3E)
    );
  }
}