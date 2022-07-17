import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple, onPrimary: Colors.white),
    textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline3: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.black)));

final lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.dark(
        primary: Colors.deepPurple, onPrimary: Colors.white),
    textTheme: const TextTheme(
        headline1: TextStyle(),
        headline3: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white)));
