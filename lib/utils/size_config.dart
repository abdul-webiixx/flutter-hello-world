import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      if (screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    screenWidth = constraints.maxWidth;
    screenHeight = constraints.maxHeight;

    _blockWidth = screenWidth! / 100;
    _blockHeight = screenHeight! / 100;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
