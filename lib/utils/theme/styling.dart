import 'package:BMI/blocs/blocs.dart';
import 'package:flutter/material.dart';

import '../size/size_config.dart';

class AppTheme {
  static String lang = "en";

  AppTheme._();

  // final  lang =   AppLocalizations().locale.languageCode;

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF75C28C);
  static const Color subTitleSmallTextColor = Color(0x99000000);

  static double languageFontTextMultiplier = 1.0;

  static ThemeData getTheme(themetype theme) {
    if (theme == themetype.light) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static ThemeData lightTheme() {
    print(
        "$languageFontTextMultiplier  $lang    8888888888888888888888888888888888");
    languageFontTextMultiplier = lang == 'fa' ? 1 : 1.0;
    // subTitleTextColor =  lang == 'fa' ? Colors.black : Colors.yellow;
    // subTitleSmallTextColor = ( lang == 'fa' ? Colors.black : Colors.deepOrange);
    // print("is lang fa: ${lang == 'fa'}");
    // print("is lang en: ${lang == 'en'}");
    // print("$subTitleSmallTextColor bbbbbbbbbbbbbbbbbbbbbbbbbb");
    return ThemeData(
        scaffoldBackgroundColor: AppTheme.appBackgroundColor,
        brightness: Brightness.light,
        textTheme: lightTextTheme,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.orange.withOpacity(0.3),
          onPrimary: Colors.black54,
          secondary: Colors.orange.withOpacity(0.7),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          secondaryContainer: Colors.black.withOpacity(0.08),
        ),
        primaryColor: Colors.orange.withOpacity(0.3),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.orange.withOpacity(0.7),
        ),
        fontFamily: lang == 'fa' ? 'IRANSansFaNum_Medium' : 'SFProDisplay');
  }

  static ThemeData darkTheme() {
    print(
        "$languageFontTextMultiplier  $lang    8888888888888888888888888888888888");
    languageFontTextMultiplier = lang == 'fa' ? 1 : 1.0;

    return ThemeData(
        // scaffoldBackgroundColor: AppTheme.appBackgroundColor,
        brightness: Brightness.light,
        textTheme: darkTextTheme,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black54,
          onPrimary: Colors.white60,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Color.fromARGB(255, 59, 54, 54),
          onBackground: Colors.white60,
          surface: Color.fromARGB(255, 53, 31, 31),
          onSurface: Colors.black87,
          secondaryContainer: Colors.white.withOpacity(0.25),
        ),

        // primaryColor: Colors.orange.withOpacity(0.3),
        fontFamily: lang == 'fa' ? 'IRANSansFaNum_Medium' : 'SFProDisplay');
  }

  // static final ThemeData darkTheme = ThemeData(
  //   scaffoldBackgroundColor: Colors.black,
  //   brightness: Brightness.dark,
  //   textTheme: darkTextTheme,
  // );

  static final TextTheme lightTextTheme = TextTheme(
    headline6: _titleLight,
    subtitle1: _subTitleSmallLight,
    subtitle2: _subTitleLight,
    button: _buttonLight,
    headline4: _greetingLight,
    headline3: _searchLight,
    bodyText1: _selectedTabLight,
    bodyText2: _unSelectedTabLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    headline6: _titleDark,
    subtitle2: _subTitleDark,
    subtitle1: _subTitleSmallDark,
    button: _buttonDark,
    headline4: _greetingDark,
    headline3: _searchDark,
    bodyText1: _selectedTabDark,
    bodyText2: _unSelectedTabDark,
  );

  static final TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontSize: 5 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: subTitleTextColor,
    fontSize: 2.5 * SizeConfig.textMultiplier * languageFontTextMultiplier,
    height: 1.5 * languageFontTextMultiplier,
    // fontWeight: FontWeight.w700,
  );

  static final TextStyle _subTitleSmallLight = TextStyle(
    color: subTitleSmallTextColor,
    fontSize: 2.0 * SizeConfig.textMultiplier * languageFontTextMultiplier,
    fontWeight: FontWeight.w600,
    height: 1.5 * languageFontTextMultiplier,
  );

  static final TextStyle _buttonLight = TextStyle(
    color: Colors.blue,
    fontSize: 2.5 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 3 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 3.2 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _selectedTabLight = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 2.0 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _unSelectedTabLight = TextStyle(
    color: Color(0xFF75C28C),
    fontSize: 2.5 * SizeConfig.textMultiplier * languageFontTextMultiplier,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark =
      _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark =
      _buttonLight.copyWith(color: Colors.white70);

  static final TextStyle _greetingDark =
      _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark =
      _searchLight.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark =
      _selectedTabLight.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark =
      _unSelectedTabLight.copyWith(color: Colors.white70);

  static final TextStyle _subTitleSmallDark =
      _subTitleSmallLight.copyWith(color: Colors.white70);
}
