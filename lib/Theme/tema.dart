import 'package:flutter/material.dart';


ColorScheme lightScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(220, 47, 130, 207),
    onPrimary: Colors.black,
    secondary: Colors.blueAccent,
    onSecondary: Colors.black,
    error: Colors.orange,
    onError: Colors.white,
    surface: Colors.lightBlue,
    onSurface: Colors.black);

IconThemeData icons = const IconThemeData(color: Colors.black);

ThemeData light = ThemeData(
  useMaterial3: true,
  fontFamily: 'Nunito',
  brightness: Brightness.light,
  colorScheme: lightScheme,
  iconTheme: icons,
  listTileTheme: ListTileThemeData(
      tileColor: lightScheme.primary,
      titleTextStyle:
          TextStyle(fontWeight: FontWeight.w500, color: lightScheme.onPrimary, fontSize: 16),
          subtitleTextStyle: TextStyle(fontWeight: FontWeight.normal, color: lightScheme.onPrimary),
      
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)))),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
);
