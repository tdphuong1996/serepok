import 'package:flutter/material.dart';

class AppThemes {
  static String QuicksandRegular = "QuicksandRegular";
  static const String QuicksandMedium = "GoogleSans";

  static const String _fontFamily = QuicksandMedium;

  // LIGHT THEME TEXT
  static const TextTheme _lightTextTheme = TextTheme(
    overline: TextStyle(color: MyColor.TEXT_COLOR, fontFamily: _fontFamily),
    headline1: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    button: TextStyle(fontSize: 15.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    caption: TextStyle(fontSize: 12.0, fontFamily: _fontFamily),
  );

  /// LIGHT THEME
  static ThemeData theme() {
    return _lightTheme;
  }

  // LIGHT THEME
  static final ThemeData _lightTheme = ThemeData(
    fontFamily: _fontFamily,
    primaryColor: MyColor.PRIMARY_COLOR,
    accentColor: MyColor.ACCENT_COLOR,
    scaffoldBackgroundColor: MyColor.LIGHT_BACKGROUND_COLOR,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyColor.PRIMARY_COLOR,
    ),
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      color: MyColor.PRIMARY_COLOR,
      iconTheme: IconThemeData(color: MyColor.ICON_COLOR),
    ),
    colorScheme: const ColorScheme.light(
      primary: MyColor.PRIMARY_COLOR,
      primaryVariant: MyColor.PRIMARY_VARIANT,
    ),
    snackBarTheme:
        const SnackBarThemeData(backgroundColor: MyColor.LIGHT_BACKGROUND_COLOR),
    iconTheme: const IconThemeData(
      color: MyColor.ICON_COLOR,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: MyColor.LIGHT_BACKGROUND_COLOR),
    textTheme: _lightTextTheme,
  );
}

/// SPACINGS DATA
class MySpace {
  /// Padding
  static const double paddingZero = 0.0;
  static const double paddingXS = 2.0;
  static const double paddingS = 4.0;
  static const double paddingM = 8.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 36.0;

  /// Margin
  static const double marginZero = 0.0;
  static const double marginXS = 2.0;
  static const double marginS = 4.0;
  static const double marginM = 8.0;
  static const double marginL = 16.0;
  static const double marginXL = 32.0;

  /// Spacing
  static const double spaceXS = 2.0;
  static const double spaceS = 4.0;
  static const double spaceM = 8.0;
  static const double spaceL = 16.0;
  static const double spaceXL = 32.0;
}

/// COLORS DATA
class MyColor {
  /// Common Colors
  static const PRIMARY_COLOR = Color(0xFF250048);
  static const MISTY_COLOR = Color(0xFFE0E0E0);
  static const Color LIGHT_BACKGROUND_COLOR = Color(0xFFF9F9F9);
  static const ACCENT_COLOR = Color(0xFF9B51E0);
  static const PRIMARY_VARIANT = Color(0xFF9B51E0);
  static const PRIMARY_VARIANT_LIGHT = Color(0xFFE8F5E9);
  static const PRIMARY_SWATCH = Color(0xFF3681EC);

  static const ICON_COLOR = Colors.white;
  static const TEXT_COLOR = Color(0xFF000000);
  static const BUTTON_COLOR = PRIMARY_COLOR;
  static const TEXT_BUTTON_COLOR = Colors.white;

  static const PRIMARY_DARK_COLOR = Color(0xFF250048);
  static const Color DARK_BACKGROUND_COLOR = Color(0xFF000000);
  static const ICON_COLOR_DARK = Colors.white;
  static const TEXT_COLOR_DARK = Color(0xFFffffff);
  static const BUTTON_COLOR_DARK = PRIMARY_DARK_COLOR;
  static const TEXT_BUTTON_COLOR_DARK = Colors.black;
}
