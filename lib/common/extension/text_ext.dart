import 'package:flutter/material.dart';

extension MText on Text {

  static Text create(String text, {
    double fontSize = 14,
    Color color = Colors.grey,
    FontWeight weight = FontWeight.normal,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          decoration: TextDecoration.none,
          fontWeight: weight,
      ),
    );
  }
}
