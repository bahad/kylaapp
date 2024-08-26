import 'package:flutter/material.dart';

class AppBorderRadius {
  static const BorderRadius small = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius large = BorderRadius.all(Radius.circular(24.0));
  static const BorderRadius avatar = BorderRadius.all(Radius.circular(120.0));

  static BorderRadius custom(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }
}
