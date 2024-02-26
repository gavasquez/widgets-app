import 'package:flutter/material.dart';

const colorsList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorsList.length,
            'Selected color must be less or equal than ${colorsList.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorsList[selectedColor],
      appBarTheme: const AppBarTheme(centerTitle: true));
}
