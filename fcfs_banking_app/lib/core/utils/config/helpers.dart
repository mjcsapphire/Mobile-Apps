import 'package:flutter/material.dart';

class Helpers {}

extension ThemeDataExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
