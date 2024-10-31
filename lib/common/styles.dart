import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF2196F3);
const Color secondaryColor = Color(0xFFBBDEFB);

ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);