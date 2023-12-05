import 'package:flutter/material.dart';

const swanRadiiMd = BorderRadius.all(Radius.circular(6.0));

enum SwanColors {
  coolBlueDark,
  coolBlue,
  trueBlue,
  golden,
}

extension SwanColorsValues on SwanColors {
  Color get value {
    switch (this) {
      case SwanColors.coolBlueDark:
        return const Color(0xFF00244C);
      case SwanColors.coolBlue:
        return const Color(0xFF00305E);
      case SwanColors.trueBlue:
        return const Color(0xFF0074C7);
      case SwanColors.golden:
        return const Color(0xFFFCC800);
      default:
        throw Exception('Invalid SwanColorsEnum value');
    }
  }
}

ButtonStyle goldenButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(borderRadius: swanRadiiMd)),
  backgroundColor: MaterialStateProperty.all<Color>(SwanColors.golden.value),
  foregroundColor: MaterialStateProperty.all<Color>(SwanColors.coolBlue.value),
  fixedSize: MaterialStateProperty.all<Size>(const Size(200, 48)),
);

ButtonStyle goldenDisabledButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(borderRadius: swanRadiiMd)),
  backgroundColor:
      MaterialStateProperty.all<Color>(SwanColors.golden.value.withAlpha(160)),
  foregroundColor: MaterialStateProperty.all<Color>(SwanColors.coolBlue.value),
  fixedSize: MaterialStateProperty.all<Size>(const Size(200, 48)),
);

var themeData = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: SwanColors.coolBlue.value,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: SwanColors.trueBlue.value,
    ),
    headlineMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
);
