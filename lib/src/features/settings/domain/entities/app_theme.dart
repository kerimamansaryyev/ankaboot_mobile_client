import 'package:ankabootmobile/src/core/ui/colors/color_schemes.g.dart';
import 'package:flutter/material.dart';

typedef _MaterialThemeResolver = ThemeData Function();

ThemeData _lightThemeResolver() => ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      colorScheme: lightColorScheme,
    );

ThemeData _darkThemeResolver() => ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: darkColorScheme,
    );

enum AppTheme {
  light._(_lightThemeResolver, lightThemeName),
  dark._(_darkThemeResolver, darkThemeName);

  final _MaterialThemeResolver _materialThemeResolver;
  final String themeName;

  const AppTheme._(this._materialThemeResolver, this.themeName);

  factory AppTheme.fromBrightness(Brightness brightness) =>
      _brightnessMapped[brightness] ?? fallback;

  static AppTheme? fromName(String name) => _stringMapped[name];

  ThemeData get themeData => _materialThemeResolver();

  static const fallback = light;
  static const lightThemeName = 'light';
  static const darkThemeName = 'dark';

  static const _stringMapped = <String, AppTheme>{
    lightThemeName: light,
    darkThemeName: dark,
  };

  static const _brightnessMapped = <Brightness, AppTheme>{
    Brightness.light: light,
    Brightness.dark: dark,
  };
}
