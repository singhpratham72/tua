import 'package:flutter/material.dart';
import 'package:tua/constants/colors.dart';
import 'fonts.dart';

class TextStyles {
  static const TextStyle h1 = TextStyle(
      fontSize: FontSize.xXXL,
      fontWeight: Weight.bold,
      color: ApplicationColors.white);
  static const TextStyle h2 = TextStyle(
      fontSize: FontSize.xL,
      fontWeight: Weight.bold,
      color: ApplicationColors.white);
  static const TextStyle h3 = TextStyle(
      fontSize: FontSize.L,
      fontWeight: Weight.bold,
      color: ApplicationColors.white);
  static const TextStyle greyText = TextStyle(
      fontSize: FontSize.M,
      fontWeight: Weight.normal,
      color: ApplicationColors.disabledGrey);
  static const TextStyle errorText = TextStyle(
      fontSize: FontSize.M,
      fontWeight: Weight.normal,
      color: ApplicationColors.errorColor);
  static TextStyle bodyText = const TextStyle(
      fontSize: FontSize.S,
      fontWeight: Weight.light,
      color: ApplicationColors.white);
  static const TextStyle textFieldStyle = TextStyle(
      fontSize: 42.0, fontWeight: Weight.bold, color: ApplicationColors.white);
  static const TextStyle keyStyle = TextStyle(
      fontSize: 32.0,
      fontWeight: Weight.normal,
      color: ApplicationColors.primaryColorDark);
}
