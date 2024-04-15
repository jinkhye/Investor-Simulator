import 'package:flutter/material.dart';

const Color darkPurple = Color(0xFF201355);
const Color purple = Color(0xFF4F4789);
const Color orange = Color(0xFFFFB17A);
const Color yellow = Color.fromRGBO(251, 231, 98, 1);
const Color orangeRed = Color(0xFFF18437);
const Color green = Color(0xFF169218);
const Color lightGreen = Color(0xFF5CD34D);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);
const Color red = Color(0xFFEE4B2B);
const Color darkRed = Color(0xFF9D0208);
const Color lightPurple = Color(0xFFCBC3E3);

Color getColorFromString(String input) {
  double value = double.tryParse(input) ?? 0.0;
  if (value > 0) {
    return lightGreen;
  } else if (value < 0) {
    return darkRed;
  } else {
    // You can return a default color or handle other cases as needed
    return Colors.grey;
  }
}

Color getColorFromQuantity(int quantity) {
  if (quantity > 0) {
    return green;
  } else {
    return red;
  }
}

Color getColorFromPercentage(double percentage) {
  if (percentage > 0) {
    return green;
  } else if (percentage == 0) {
    return Colors.grey;
  } else {
    return red;
  }
}
