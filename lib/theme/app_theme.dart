import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const blue = Color(0xFF2859F4);
  static const ink = Color(0xFF17202F);
  static const muted = Color(0xFF68758C);
  static const border = Color(0xFFDCE3ED);
  static const darkSurface = Color(0xFF101722);
  static const darkRaised = Color(0xFF1B2432);
  static const darkInk = Color(0xFFEAF0FC);
  static const darkMuted = Color(0xFFA0AEC2);
  static const darkBorder = Color(0xFF2D394A);
  static const darkBlue = Color(0xFF80A7FF);

  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: blue,
      primary: blue,
      surface: Colors.white,
    ),
    fontFamily: 'Roboto',
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkSurface,
    colorScheme: ColorScheme.fromSeed(
      seedColor: blue,
      brightness: Brightness.dark,
      primary: darkBlue,
      surface: darkSurface,
    ),
    dividerColor: darkBorder,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: darkInk,
      displayColor: darkInk,
    ),
    fontFamily: 'Roboto',
  );

  static Color inkFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkInk : ink;

  static Color mutedFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkMuted : muted;

  static Color borderFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBorder : border;

  static Color raisedFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkRaised : Colors.white;
}
