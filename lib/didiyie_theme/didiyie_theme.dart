import 'package:flutter/material.dart';

import '../didiyie_gloableclass/didiyie_color.dart';
import '../didiyie_gloableclass/didiyie_fontstyle.dart';


class StudySyncThemes {
  static final lightTheme = ThemeData(

    primaryColor: StudySyncColor.appcolor,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(),
    fontFamily: 'mulishmedium',
    scaffoldBackgroundColor: StudySyncColor.white,
    appBarTheme: AppBarTheme(
      iconTheme:  const IconThemeData(color: StudySyncColor.black),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: mulishmedium.copyWith(
        color: StudySyncColor.black,
        fontSize: 16,
      ),
      color: StudySyncColor.transparent,
    ),
  );

  static final darkTheme = ThemeData(

    fontFamily: 'mulishmedium',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: StudySyncColor.white),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: mulishmedium.copyWith(
        color: StudySyncColor.white,
        fontSize: 15,
      ),
      color: StudySyncColor.transparent,
    ),
  );
}

class didiyieThemes {
  static final lightTheme = ThemeData(
    primaryColor: didiyieColor.appcolor,
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(),
    fontFamily: 'MulishMedium',
    scaffoldBackgroundColor: didiyieColor.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: didiyieColor.black),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: didiyieColor.black,
        fontSize: 16,
        fontFamily: 'MulishMedium',
      ),
      color: didiyieColor.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'MulishMedium',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: didiyieColor.white),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: didiyieColor.white,
        fontSize: 15,
        fontFamily: 'MulishMedium',
      ),
      color: didiyieColor.transparent,
    ),
  );
}