import 'package:flutter/material.dart';

class TutorialItem {
  GlobalKey key;
  int order;
  String instruction;
  TextStyle? style;
  ButtonStyle? buttonStyle;

  TutorialItem({
    required this.key,
    required this.instruction,
    this.order = 0,
    this.style,
    this.buttonStyle,
  });
}
