import 'package:flutter/material.dart';

extension ThemeGetterExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}
