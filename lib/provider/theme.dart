import 'package:flutter/material.dart';
import 'package:Zenith/helper/color.dart';

class ThemeProvider with ChangeNotifier {
  final darkTheme = ThemeData(
    scaffoldBackgroundColor: black,
    hintColor: grey,
    highlightColor: highlightColor,
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    primaryColorLight: white,
    accentColor: Colors.white,
    backgroundColor: black,
    shadowColor: lightGray,
    errorColor: red,
    toggleableActiveColor: green,
    accentIconTheme: IconThemeData(color: Colors.black),
  );
}
